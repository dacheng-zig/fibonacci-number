const std = @import("std");

pub fn main() !void {
    const max = 20;

    const thread1 = try std.Thread.spawn(.{}, struct {
        fn run() void {
            for (0..max) |i| {
                const n: i64 = @as(i64, @intCast(i));
                const result = fib1(n);
                std.debug.print("fib1({d}) => {d}\n", .{ n, result });
            }
        }
    }.run, .{});

    const thread2 = try std.Thread.spawn(.{}, struct {
        fn run() void {
            for (0..max) |i| {
                const n: i64 = @as(i64, @intCast(i));
                const result = fib2(n);
                std.debug.print("fib2({d}) => {d}\n", .{ n, result });
            }
        }
    }.run, .{});

    const thread3 = try std.Thread.spawn(.{}, struct {
        fn run() void {
            for (0..max) |i| {
                const n: i64 = @as(i64, @intCast(i));
                const result = fib3(n);
                std.debug.print("fib3({d}) => {d}\n", .{ n, result });
            }
        }
    }.run, .{});

    thread1.join();
    thread2.join();
    thread3.join();
}

// Recursive fibonacci using if statements
fn fib1(n: i64) i64 {
    if (n == 0) return 0;
    if (n == 1) return 1;
    return fib1(n - 1) + fib1(n - 2);
}

// Recursive fibonacci using switch
fn fib2(n: i64) i64 {
    return switch (n) {
        0 => 0,
        1 => 1,
        else => fib2(n - 1) + fib2(n - 2),
    };
}

// Iterative fibonacci
fn fib3(n: i64) i64 {
    if (n <= 0) return 0;
    if (n == 1) return 1;

    var a: i64 = 0;
    var b: i64 = 1;
    var i: i64 = 2;
    var result: i64 = 0;

    while (i <= n) : (i += 1) {
        result = a + b;
        a = b;
        b = result;
    }

    return result;
}
