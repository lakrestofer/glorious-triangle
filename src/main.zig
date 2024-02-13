const std = @import("std");
const ray = @import("raylib.zig");

fn draw() void {
    ray.BeginDrawing();
    defer ray.EndDrawing();

    ray.ClearBackground(ray.RAYWHITE);

    ray.DrawText("Congrats! You created your first window!", 190, 200, 20, ray.LIGHTGRAY);
}

pub fn main() !void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;

    ray.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
    defer ray.CloseWindow(); // close window and deinit opengl context on exit

    ray.SetTargetFPS(60); // Set our game to run at 60 frames-per-second

    while (!ray.WindowShouldClose()) // Detect window close button or ESC key
    {
        draw();
    }
}
