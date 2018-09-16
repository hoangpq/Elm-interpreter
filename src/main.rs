#![allow(dead_code, unused_imports)]

#[macro_use]
extern crate nom;
#[macro_use]
extern crate pretty_assertions;

use nom::*;
use nom::simple_errors::Context;
use parsers::module_parser::*;
use std::fs::File;
use std::io;
use std::io::Read;
use std::io::Write;
use tokenizer::*;
use types::*;
use util::*;

mod types;
#[macro_use]
mod util;
mod parsers;
mod tokenizer;

fn load_file() -> Vec<u8> {
    let mut file = File::open("example.elm").expect("Example file not found");
    let mut data: Vec<u8> = Vec::new();
    file.read_to_end(&mut data).unwrap();

    data
}

fn main() {
    let file = load_file();
    let tokens = get_all_tokens(&file);
    let result = read_module(&tokens);

    if let Ok((rest, module)) = result {
        println!("Remaining: {:?}\n", rest);
        println!("Output: {:?}", module);
    } else {
        println!("{:?}", result);
    }
}

fn print<T: std::fmt::Debug>(r: IResult<&[u8], T>) {
    match r {
        Ok((str, t)) => {
            println!("{:?}, rest: '{}'", t, to_string(str));
        }
        Err(e) => {
            match e {
                Err::Error(ctx) => {
                    match ctx {
                        Context::Code(c, ..) => {
                            println!("Erro, rest: {:?}", to_string(c));
                        }
                    }
                }
                Err::Incomplete(needed) => {
                    println!("Inco: {:?}", needed);
                }
                Err::Failure(ctx) => {
                    println!("Fail: {:?}", ctx);
                }
            }
        }
    }
}

