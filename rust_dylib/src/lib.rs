use godot::{classes::INode2D, prelude::*};
use std::str::FromStr;

struct MyExtension;

#[gdextension]
unsafe impl ExtensionLibrary for MyExtension {}

#[derive(GodotClass)]
#[class(base=Node2D)]
struct Example {}

#[godot_api]
impl INode2D for Example {
    fn init(_base: Base<Node2D>) -> Self {
        Self {}
    }

    fn ready(&mut self) {
        godot_print!("Hello world from Rust!");
    }
}

#[godot_api]
impl Example {
    #[func]
    fn rust() -> GString {
        GString::from_str("Rust").expect("Failed to generate GString")
    }
}
