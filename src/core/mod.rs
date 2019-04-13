use std::collections::HashMap;
use std::sync::Arc;

use analyzer::static_env::StaticEnv;
use ast::Module;
use ast::ModuleExposing;
use ast::ModuleHeader;
use ast::Statement;
use ast::Type;
use constructors::type_of;
use core::basics::get_basics_funs;
use core::bitwise::get_bitwise_funs;
use core::char::get_char_funs;
use core::debug::get_debug_funs;
use core::list::get_list_funs;
use core::operators::get_operators_types;
use core::string::get_string_types;
use core::utils::get_utils_funs;
use errors::ElmError;
use errors::RuntimeError;
use interpreter::Interpreter;
use loader::AnalyzedModule;
use loader::Declaration;
use loader::RuntimeModule;
use types::ElmFn;
use types::ExternalFunc;
use types::Function;
use types::next_fun_id;
use types::Value;
use util::arg_count;

mod basics;
mod debug;
mod char;
mod string;
mod list;
mod bitwise;
mod utils;
mod operators;

pub fn get_core_kernel_modules() -> Vec<(&'static str, AnalyzedModule, RuntimeModule)> {
    vec![
        core_kernel_module("Elm.Kernel.Basics", get_basics_funs),
        core_kernel_module("Elm.Kernel.Utils", get_utils_funs),
        core_kernel_module("Elm.Kernel.Bitwise", get_bitwise_funs),
        core_kernel_module("Elm.Kernel.Debug", get_debug_funs),
        core_kernel_module("Elm.Kernel.Char", get_char_funs),
        core_kernel_module("Elm.Kernel.List", get_list_funs),
    ]
}

pub fn register_core(env: &mut StaticEnv) {}

pub fn builtin_record_access() -> ExternalFunc {
    let fun: ElmFn = |_, args| {
        match &args[0] {
            Value::Record(entries) => {
                if let Value::String(field) = &args[1] {
                    let opt = entries.iter()
                        .find(|(name, _)| name == field)
                        .map(|(_, val)| val);

                    match opt {
                        Some(val) => Ok(val.clone()),
                        None => {
                            Err(ElmError::Interpreter {
                                info: RuntimeError::RecordFieldNotFound(field.clone(), args[0].clone())
                            })
                        }
                    }
                } else {
                    Err(ElmError::Interpreter {
                        info: RuntimeError::InternalErrorRecordAccess(args[1].clone())
                    })
                }
            }
            _ => Err(ElmError::Interpreter {
                info: RuntimeError::ExpectedRecord(args[0].clone())
            })
        }
    };

    ExternalFunc { name: "record access".to_string(), fun }
}

fn func_of(name: &'static str, ty: &'static str, fun: ElmFn) -> (&'static str, Type, Value) {
    let func_type = type_of(ty);
    let external = ExternalFunc { name: name.to_string(), fun };
    let func = Value::Fun {
        arg_count: arg_count(&func_type),
        args: vec![],
        fun: Arc::new(Function::External(next_fun_id(), external, func_type.clone())),
    };

    (name, func_type, func)
}

fn core_kernel_module(name: &'static str, func: fn() -> Vec<(&'static str, Type, Value)>) -> (&'static str, AnalyzedModule, RuntimeModule) {
    let mut all_declarations = vec![];
    let mut definitions = HashMap::new();

    for (name, ty, val) in func() {
        all_declarations.push(Declaration::Port(name.to_string(), ty));
        definitions.insert(name.to_string(), val);
    }

    (
        name,
        AnalyzedModule {
            name: name.to_string(),
            dependencies: vec![],
            all_declarations,
            definitions: vec![],
            imports: vec![],
        },
        RuntimeModule {
            name: name.to_string(),
            definitions,
            imports: vec![],
        }
    )
}

pub fn get_core_module_by_path(path: &Vec<String>) -> Option<Module> {
    let slices: Vec<_> = path.iter().map(|x| x.as_str()).collect();

    match slices[..] {
        ["Elm", "Kernel", "String"] => {
            Some(create_module("Elm.Kernel.String", get_string_types()))
        }
        _ => None
    }
}

fn create_module(name: &str, types: Vec<(&str, Type)>) -> Module {
    let header = ModuleHeader {
        name: String::from(name),
        exposing: ModuleExposing::All,
    };

    let mut statements = vec![];

    for (def, ty) in types {
        statements.push(Statement::Port(String::from(def), ty));
    }

    Module { header: Some(header), imports: vec![], statements }
}

fn ignore(_: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    unimplemented!()
}


// Combinators

// Identity
// a -> a
pub fn builtin_id(_: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    Ok(args[0].clone())
}

// self application
// f = f f
// Has recursive type
pub fn builtin_mockingbird(i: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    i.apply_function(args[0].clone(), &[args[0].clone()])
}

// True, first, const
// a -> b -> a
pub fn builtin_kestrel(_: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    Ok(args[0].clone())
}

// False, second
// a -> b -> b
pub fn builtin_kite(_: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    Ok(args[1].clone())
}

// Invert order, flip
// (a -> b -> c) -> b -> a -> c
pub fn builtin_cardinal(i: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    let abc = &args[0];
    let b = &args[1];
    let a = &args[2];

    i.apply_function(abc.clone(), &[a.clone(), b.clone()])
}

// Composition
// (b -> c) -> (a -> b) -> a -> c
pub fn builtin_bluebird(i: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    let bc = &args[0];
    let ab = &args[1];
    let a = &args[2];
    let b = i.apply_function(ab.clone(), &[a.clone()])?;

    i.apply_function(bc.clone(), &[b])
}

// hold an argument
// a -> (a -> b) -> b
pub fn builtin_thrush(i: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    let a = &args[0];
    let ab = &args[1];

    i.apply_function(ab.clone(), &[a.clone()])
}

// Hold 2 arguments
// a -> b -> (a -> b -> c) -> c
pub fn builtin_vireo(i: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    let a = &args[0];
    let b = &args[1];
    let abc = &args[2];

    i.apply_function(abc.clone(), &[a.clone(), b.clone()])
}

// Double composition
// (c -> d) -> (a -> b -> c) -> a -> b -> d
pub fn builtin_blackbird(i: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    let cd = &args[0];
    let abc = &args[1];
    let a = &args[2];
    let b = &args[2];
    let c = i.apply_function(abc.clone(), &[a.clone(), b.clone()])?;

    i.apply_function(cd.clone(), &[c])
}

// (a -> b -> c) -> (a -> b) -> a -> c
pub fn builtin_starling(i: &mut Interpreter, args: &[Value]) -> Result<Value, ElmError> {
    let abc = &args[0];
    let ab = &args[1];
    let a = &args[2];
    let b = i.apply_function(ab.clone(), &[a.clone()])?;

    i.apply_function(abc.clone(), &[a.clone(), b])
}
