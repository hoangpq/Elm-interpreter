use analyzer::static_env::StaticEnv;
use analyzer::type_helper::calculate_common_type;
use ast::*;
use constructors::type_char;
use constructors::type_int;
use constructors::type_list;
use constructors::type_string;
use constructors::type_var;
use errors::PatternMatchingError;
use util::create_vec;
use util::VecExt;

pub fn is_exhaustive(pattern: &Pattern) -> bool {
    match pattern {
        Pattern::Var(_, _) => true,
        Pattern::Adt(_, _, _) => true,
        Pattern::Wildcard(_, ) => true,
        Pattern::Unit(_, ) => true,
        Pattern::Tuple(_, sub_patterns) => {
            sub_patterns.iter().all(|p| is_exhaustive(p))
        }
        Pattern::List(_, _) => false,
        Pattern::Alias(_, pat, _) => is_exhaustive(pat),
        Pattern::BinaryOp(_, _, _, _) => false,
        Pattern::Record(_, _) => true,
        Pattern::LitInt(_, _) => false,
        Pattern::LitString(_, _) => false,
        Pattern::LitChar(_, _) => false,
    }
}

pub fn analyze_pattern(env: &mut StaticEnv, pattern: &Pattern) -> Result<(Type, Vec<(String, Type)>), PatternMatchingError> {
    match pattern {
        Pattern::Var(_, name) => {
            let ty_name = env.name_seq.next();
            Ok((Type::Var(ty_name.clone()), vec![(name.to_owned(), Type::Var(ty_name))]))
        }
        Pattern::Adt(_, name, sub_patterns) => {
            let mut sub_input = Vec::new();
            let mut sub_vars = Vec::new();

            for pattern in sub_patterns {
                let (ty, vars) = analyze_pattern(env, pattern)?;
                sub_input.push(ty);
                for v in vars {
                    sub_vars.push(v);
                }
            }

            let adt = env.find_adt_variant(name)
                .ok_or_else(|| PatternMatchingError::UnknownAdtVariant(name.clone()))?;

            // TODO error Maybe vs Maybe a
            Ok((Type::Tag(adt.name.clone(), sub_input), sub_vars))
        }
        Pattern::Wildcard(_) => {
            Ok((Type::Var(env.name_seq.next()), vec![]))
        }
        Pattern::Unit(_) => {
            Ok((Type::Unit, vec![]))
        }
        Pattern::Tuple(_, sub_patterns) => {
            let mut sub_input = Vec::new();
            let mut sub_vars = Vec::new();

            for pattern in sub_patterns {
                let (ty, vars) = analyze_pattern(env, pattern)?;
                sub_input.push(ty);
                for v in vars {
                    sub_vars.push(v);
                }
            }

            Ok((Type::Tuple(sub_input), sub_vars))
        }
        Pattern::List(_, sub_patterns) => {
            let mut sub_input = Vec::new();
            let mut sub_vars = Vec::new();

            for pattern in sub_patterns {
                let (ty, vars) = analyze_pattern(env, pattern)?;
                sub_input.push(ty);
                for v in vars {
                    sub_vars.push(v);
                }
            }

            let ty = if sub_input.is_empty() {
                type_var("a")
            } else {
                calculate_common_type(&sub_input)
                    .map_err(|(expected, found)| {
                        PatternMatchingError::ListPatternsAreNotHomogeneous(expected.clone(), found.clone())
                    })?
                    .clone()
            };

            Ok((type_list(ty), sub_vars))
        }
        Pattern::BinaryOp(_, operand, left, right) => {
            if operand != "::" {
                return Err(PatternMatchingError::UnknownOperatorPattern(operand.clone()));
            }

            let (left_ty, left_vars) = analyze_pattern(env, left)?;
            let (_, right_vars) = analyze_pattern(env, right)?;

            Ok((type_list(left_ty), left_vars.join_vec(&right_vars)))
        }
        Pattern::Record(_, entry_names) => {
            let mut entries = Vec::new();

            for name in entry_names {
                entries.push((name.to_owned(), Type::Var(env.name_seq.next())));
            }

            Ok((Type::Record(entries.clone()), entries))
        }
        Pattern::LitInt(_, _) => Ok((type_int(), vec![])),
        Pattern::LitString(_, _) => Ok((type_string(), vec![])),
        Pattern::LitChar(_, _) => Ok((type_char(), vec![])),
        Pattern::Alias(_, pat, alias) => {
            let (ret_ty, vars) = analyze_pattern(env, pat)?;
            Ok((ret_ty.clone(), create_vec((alias.to_owned(), ret_ty), vars)))
        }
    }
}

pub fn analyze_pattern_with_type(env: &mut StaticEnv, pattern: &Pattern, ty: Type) -> Result<(Type, Vec<(String, Type)>), PatternMatchingError> {
    match pattern {
        Pattern::Var(_, name) => {
            Ok((ty.clone(), vec![(name.to_owned(), ty)]))
        }
        Pattern::Adt(_, name, sub_patterns) => {
            let mut sub_input = Vec::new();
            let mut sub_vars = Vec::new();

            let adt = env.find_adt_variant(name)
                .ok_or_else(|| PatternMatchingError::UnknownAdtVariant(name.clone()))?;

            let variant = adt.variants.iter().find(|v| &v.name == name).unwrap();

            let params = if let Type::Tag(ty_name, _) = ty.clone() {
                if ty_name == adt.name {
                    assert_eq!(variant.types.len(), sub_patterns.len());
                    variant.types.clone()
                } else {
                    return Err(PatternMatchingError::ExpectedAdt(adt.name.clone(), ty));
                }
            } else {
                return Err(PatternMatchingError::ExpectedAdt(adt.name.clone(), ty.clone()));
            };

            for (pattern, param_ty) in sub_patterns.iter().zip(params) {
                let (ty, vars) = analyze_pattern_with_type(env, pattern, param_ty)?;
                sub_input.push(ty);
                for v in vars {
                    sub_vars.push(v);
                }
            }

            Ok((Type::Tag(adt.name.clone(), sub_input), sub_vars))
        }
        Pattern::Wildcard(_) => {
            Ok((ty, vec![]))
        }
        Pattern::Unit(_) => {
            if ty != Type::Unit {
                return Err(PatternMatchingError::ExpectedUnit(ty));
            }
            Ok((Type::Unit, vec![]))
        }
        Pattern::Tuple(_, sub_patterns) => {
            let mut sub_input = Vec::new();
            let mut sub_vars = Vec::new();

            match ty {
                Type::Tuple(sub_types) => {
                    assert_eq!(sub_types.len(), sub_patterns.len());

                    for (pattern, ty) in sub_patterns.iter().zip(sub_types) {
                        let (ty, vars) = analyze_pattern_with_type(env, pattern, ty)?;
                        sub_input.push(ty);
                        for v in vars {
                            sub_vars.push(v);
                        }
                    }

                    Ok((Type::Tuple(sub_input), sub_vars))
                }
                _ => {

                    // TODO this is temporary until a new type inference system is implemented
                    for pattern in sub_patterns.iter() {
                        let (ty, vars) = analyze_pattern(env, pattern)?;
                        sub_input.push(ty);
                        for v in vars {
                            sub_vars.push(v);
                        }
                    }

                    Ok((Type::Tuple(sub_input), sub_vars))
//                    return Err(PatternMatchingError::ExpectedTuple(pattern.clone(), ty));
                }
            }
        }
        Pattern::List(_, sub_patterns) => {
            let mut sub_vars = Vec::new();
            let list_param = get_list_param_type(&ty)?;

            for pattern in sub_patterns {
                let (_, vars) = analyze_pattern_with_type(env, pattern, list_param.clone())?;
                for v in vars {
                    sub_vars.push(v);
                }
            }

            Ok((type_list(list_param.clone()), sub_vars))
        }
        Pattern::Record(_, pattern_entries) => {
            let mut entries = Vec::new();
            let pairs = get_record_entries(&ty)?;

            for pattern_name in pattern_entries {
                let (name, ty) = pairs.iter()
                    .find(|(name, _)| name == pattern_name)
                    .ok_or_else(|| PatternMatchingError::InvalidRecordEntryName(pattern_name.clone()))?;

                entries.push((name.to_owned(), ty.clone()));
            }

            Ok((ty.clone(), entries))
        }
        Pattern::BinaryOp(_, operand, left, right) => {
            if operand != "::" {
                return Err(PatternMatchingError::UnknownOperatorPattern(operand.clone()));
            }

            let list_param = get_list_param_type(&ty)?;
            let (_, left_vars) = analyze_pattern_with_type(env, left, list_param.clone())?;
            let (_, right_vars) = analyze_pattern_with_type(env, right, ty.clone())?;

            Ok((type_list(list_param.clone()), left_vars.join_vec(&right_vars)))
        }
        Pattern::LitInt(_, _) => {
            if let Type::Var(name) = &ty {
                if name != "number" {
                    return Err(PatternMatchingError::ExpectedLiteral("Int or number".to_owned(), ty.clone()));
                }
            } else {
                check_type_literal(&ty, "Int")?;
            }
            Ok((ty, vec![]))
        }
        Pattern::LitString(_, _) => {
            check_type_literal(&ty, "String")?;
            Ok((ty, vec![]))
        }
        Pattern::LitChar(_, _) => {
            check_type_literal(&ty, "Char")?;
            Ok((ty, vec![]))
        }
        Pattern::Alias(_, pat, alias) => {
            let (ret_ty, vars) = analyze_pattern_with_type(env, pat, ty)?;
            Ok((ret_ty.clone(), create_vec((alias.to_owned(), ret_ty), vars)))
        }
    }
}

fn check_type_literal(ty: &Type, literal_name: &str) -> Result<(), PatternMatchingError> {
    match ty {
        Type::Tag(name, params) => {
            if name != literal_name || !params.is_empty() {
                Err(PatternMatchingError::ExpectedLiteral(literal_name.to_owned(), ty.clone()))
            } else {
                Ok(())
            }
        }
        _ => Err(PatternMatchingError::ExpectedLiteral(literal_name.to_owned(), ty.clone()))
    }
}

fn get_list_param_type(ty: &Type) -> Result<&Type, PatternMatchingError> {
    match ty {
        Type::Tag(type_name, params) => {
            if type_name != "List" || params.len() != 1 {
                return Err(PatternMatchingError::ExpectedListType(ty.clone()));
            }

            Ok(&params[0])
        }
        _ => {
            Err(PatternMatchingError::ExpectedListType(ty.clone()))
        }
    }
}

fn get_record_entries(ty: &Type) -> Result<&Vec<(String, Type)>, PatternMatchingError> {
    match ty {
        Type::Record(entries) => Ok(entries),
        _ => Err(PatternMatchingError::ExpectedRecord(ty.clone())),
    }
}
