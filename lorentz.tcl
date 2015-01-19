#!/bin/sh
# the next line restarts using wish \
exec tclsh8.5 "$0" "$@"

# vim:shiftwidth=2
# vim:tabstop=2

# draw lorenz attractor
#
# dprelec, 2015-01-19

package require Tk

global entry_iter
global entry_a
global entry_b
global entry_c 
set entry_a 10.0
set entry_b 28.0
set entry_c [expr {8.0/3.0}]

global x1
global y1

proc next_x {x y a} {
  return [expr {1 - $a * $x * $x + $y}]
}

proc next_y {x b} {
  return [expr $b * $x]
}

proc draw_gui {} {
  pack [frame .f] -side top
  pack [label .f.title -text "Lorenz system" -font {Helvetica 12}] -side top
  pack [canvas .f.canvas -width 500 -height 500] -side top
  pack [frame .f.ctrl] -side top
  pack [label .f.ctrl.a -text "a:"] -side left
  pack [entry .f.ctrl.ea -textvariable entry_a -width 7] -side left
  pack [label .f.ctrl.b -text "b:"] -side left 
  pack [entry .f.ctrl.eb -textvariable entry_b -width 7] -side left
  pack [label .f.ctrl.c -text "c:"] -side left
  pack [entry .f.ctrl.ec -textvariable entry_c -width 7] -side left
  pack [button .f.ctrl.redraw -text "Redraw" -command redraw_map] -side left
  pack [button .f.ctrl.exit -text "Exit" -command exit] -side left

  bind . <Escape> exit
}


proc draw_lorentz {} {
  global entry_a
  global entry_b
  global entry_c
  set x 0.1
  set y 0.0
  set z 0.0
  set a $entry_a
  set b $entry_b
  set c $entry_c 
  set t 0.001
  set iter 50000
  set i 1

  .f.canvas delete dot
  for {set i 0} {$i < $iter} {set i [expr {$i + 1}]} {
    set xn [expr {$x + $t * $a * ($y - $x)}]
    set yn [expr {$y + $t * ($x * ($b - $z) - $y)}]
    set zn [expr {$z + $t * ($x * $y - $c * $z)}]

    set x $xn
    set y $yn
    set z $zn

    draw_dot $i $x $y $z
  }
}

proc draw_dot {i x y z} {
  set colors "red green blue yellow"
  set rect_x1 [expr {250 + 10 * $x}]
  set rect_y1 [expr {220 + 10 * $y}]
  set rect_x2 [expr {$rect_x1 + 1}]
  set rect_y2 [expr {$rect_y1 + 1}]
  .f.canvas create line $rect_x1 $rect_y1 $rect_x2 $rect_y2 -tag dot
}

proc redraw_map {} {
  draw_lorentz
}

proc main {} {
  draw_gui
  draw_lorentz 
}

main


