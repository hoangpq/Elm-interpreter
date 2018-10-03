// Development only {
// cargo watch -s 'clear && cargo test'
#![allow(dead_code, unused_imports)]
// }

#[macro_use]
extern crate nom;
#[macro_use]
extern crate pretty_assertions;

use analyzer::environment::StaticEnv;
use analyzer::type_analyzer::get_type;
use nom::ExtendInto;
use nom::IResult;
use nom::verbose_errors::Context;
use parsers::expression::read_expr;
use parsers::module::*;
use parsers::statement::top_level_statement;
use std::fs::File;
use std::io;
use std::io::BufRead;
use std::io::Read;
use std::io::stdin;
use std::io::stdout;
use std::io::Write;
use tokenizer::*;
use types::*;
use util::*;

mod types;
#[macro_use]
mod util;
mod parsers;
mod tokenizer;
mod analyzer;
mod interpreter;

fn main() {
    interpret_stdin();
}

fn interpret_stdin() {
    print!("> ");
    stdout().flush().unwrap();
    let stdin = stdin();

    for line in stdin.lock().lines() {
        if let Err(s) = run_line(&line.unwrap().as_bytes()) {
            println!("Error: {}", s);
        }
    }
}

fn run_line(line: &[u8]) -> Result<(), String> {
    use nom::*;
    let tokens = get_all_tokens(line);
    let env = StaticEnv::new();

    let (_, expr) = read_expr(&tokens).map_err(|e| format!("{:?}", e))?;
    let expr_type = get_type(&env, &expr).map_err(|e| format!("{:?}", e))?;

    println!("{:?} : {}", expr, expr_type);

    println!();
    Ok(())
}

fn load_file() -> Vec<u8> {
    let mut file = File::open("example.elm").expect("Example file not found");
    let mut data: Vec<u8> = Vec::new();
    file.read_to_end(&mut data).unwrap();

    data
}

fn interpret_file() {
    let file = load_file();
    let tokens = get_all_tokens(&file);
//        println!("Tokens: \n{:#?}\n", tokens);

    let result = read_module(&tokens);

    if let Ok((rest, module)) = result {
        println!("Remaining: {:?}\n", rest);
        println!("Output: \n{:#?}", module);
    } else {
        println!("{:?}", result);
    }
}