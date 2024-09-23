{ config, lib, pkgs, ... }:
{
    h = "move_char_left";
    j = "move_visual_line_down";
    k = "move_visual_line_up";
    l = "move_char_right";
    left="move_char_left";
    down="move_visual_line_down";
    up  ="move_visual_line_up";
    right="move_char_right";

    "0" = "goto_line_start";
    "$" = "goto_line_end";
    "@" = "replay_macro";
    q = "record_macro";
    x = "delete_char_forward";
    X = "delete_char_backward";
    ";" = "repeat_last_motion";
    C-r = "redo";
}
