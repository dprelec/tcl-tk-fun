#!/bin/sh
# the next line restarts using wish \
exec tclsh8.5 "$0" "$@"

# vim:shiftwidth=2
# vim:tabstop=2

# draw henon map
# (http://en.wikipedia.org/wiki/H%C3%A9non_map)
#
# dprelec, 2014-10-09

global entry_iter
global entry_a
global entry_b
global x1
global y1

proc next_x {x y a} {
  return [expr {1 - $a * $x * $x + $y}]
}

proc next_y {x b} {
  return [expr $b * $x]
}

proc draw_gui {} {
  global entry_a
  global entry_b 
  pack [frame .f] -side top
  pack [label .f.title -text "Hénon map" -font {Helvetica 12}] -side top
  pack [canvas .f.henon -width 500 -height 500] -side top
  pack [frame .f.ctrl] -side top
  pack [label .f.ctrl.iter -text "Iter:"] -side left
  pack [entry .f.ctrl.eiter -textvariable entry_iter -width 7] -side left 
  pack [label .f.ctrl.a -text "a:"] -side left
  pack [entry .f.ctrl.ea -textvariable entry_a -width 7] -side left
  pack [label .f.ctrl.b -text "b:"] -side left 
  pack [entry .f.ctrl.eb -textvariable entry_b -width 7] -side left
  pack [button .f.ctrl.redraw -text "Redraw map" -command redraw_map] -side left
  pack [button .f.ctrl.exit -text "Exit" -command exit] -side left

  bind . <Escape> exit
}


proc draw_map {x1 y1 a b} {
  global entry_iter 
  .f.henon delete dot
  for {set i 0} {$i <= $entry_iter} {incr i} {
    set xn [next_x $x1 $y1 $a]
    set yn [next_y $x1 $b]

    set rect_x1 [expr {250 + 150 * $xn}]
    set rect_y1 [expr {220 + 400 * $yn}]
    set rect_x2 [expr {$rect_x1 + 1}]
    set rect_y2 [expr {$rect_y1 + 1}]

    .f.henon create line $rect_x1 $rect_y1 $rect_x2 $rect_y2 -tags dot

    set x1 $xn
    set y1 $yn
  }
}

proc redraw_map {} {
  global entry_a
  global entry_b
  global x1 
  global y1

  draw_map $x1 $y1 $entry_a $entry_b 
}

proc main {} {
  global entry_iter
  global entry_a 
  global entry_b 
  global x1 y1
  
  set x1 0.63
  set y1 0.19
  set a 1.4
  set b 0.3
  
  set entry_a $a
  set entry_b $b
  set entry_iter 5000
  
  draw_gui
  draw_map $x1 $y1 $a $b
}

main


