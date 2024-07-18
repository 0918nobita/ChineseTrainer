use godot::{classes::INode2D, prelude::*};

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
