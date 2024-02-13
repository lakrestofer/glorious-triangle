const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // ====== build options ======
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const strip = b.option(
        bool,
        "strip",
        "Strip debug info to reduce binary size, defaults to false",
    ) orelse false;

    const raylib_optimize = b.option(
        std.builtin.OptimizeMode,
        "raylib-optimize",
        "Prioritize performance, safety, or binary size (-O flag), defaults to value of optimize option",
    ) orelse optimize;

    // ====== build raylib dependency =====
    const raylib_dep = b.dependency("raylib", .{
        .target = target,
        .optimize = raylib_optimize,
    });

    // ====== build executable =====
    const exe = b.addExecutable(.{
        .name = "glorious-triangle",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.strip = strip;
    exe.linkLibrary(raylib_dep.artifact("raylib"));
    b.installArtifact(exe);

    // ====== build tests =====
    const exe_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    // ====== Configure steps (run/test)
    // run step (zig build run)
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // test step (zig build test)
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
