const std = @import("std");
const ray = @import("raylib.zig");
const RayVector2 = ray.Vector2;

inline fn Vector2(x: f32, y: f32) RayVector2 {
    return RayVector2{ .x = x, .y = y };
}

fn draw(screen_width: f32, screen_height: f32) void {
    ray.BeginDrawing();
    defer ray.EndDrawing();

    ray.ClearBackground(ray.RAYWHITE);
    ray.DrawText("behold the glorious triangle!", 20, 20, 20, ray.DARKGRAY);

    const first: RayVector2 = Vector2(screen_width / 2.0, screen_height / 3.0);
    const second: RayVector2 = Vector2(screen_width / 3.0, screen_height - screen_height / 3.0);
    const third: RayVector2 = Vector2(screen_width - screen_width / 3.0, screen_height - screen_height / 3.0);
    ray.DrawTriangle(first, second, third, ray.RED);
}

pub fn main() !void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screen_width = 800;
    const screen_height = 450;

    ray.InitWindow(screen_width, screen_height, "raylib [core] example - basic window");
    defer ray.CloseWindow(); // close window and deinit opengl context on exit

    ray.SetTargetFPS(60); // Set our game to run at 60 frames-per-second

    while (!ray.WindowShouldClose()) // Detect window close button or ESC key
    {
        draw(screen_width, screen_height);
    }
}
