#!/bin/sh
# the next line restarts using wish \
exec tclsh8.5 "$0" "$@"

# vim:shiftwidth=2
# vim:tabstop=2

# draw bifurcation diagram 
# (http://en.wikipedia.org/wiki/Bifurcation_diagram)
#
# dprelec, 2014-10-10

package require Tk

global entry_iter

proc next_x {x r} {
  return [expr {$r * $x * (1 - $x)}]
}

proc draw_gui {} {
  pack [frame .f] -side top
  pack [label .f.title -text "Bifurcation diagram" -font {Helvetica 12}] -side top
  pack [canvas .f.diagram -width 500 -height 500] -side top
  pack [frame .f.ctrl] -side top
  pack [label .f.ctrl.iter -text "Iter:"] -side left
  pack [entry .f.ctrl.eiter -textvariable entry_iter -width 7] -side left 
  pack [button .f.ctrl.redraw -text "Redraw diagram" -command redraw_diagram] -side left
  pack [button .f.ctrl.exit -text "Exit" -command exit] -side left

  bind . <Escape> exit
}


proc draw_diagram {iter} {
  .f.diagram delete dot
  set x1 0.1
  for {set bigr 110} {$bigr <= 400} {incr bigr} {
    set r [expr {$bigr/100.}]
    for {set i 0} {$i <= $iter} {incr i} {
      set xn [next_x $x1 $r]

      set rect_x1 [expr {120 * $r}]
      set rect_y1 [expr {320 - 200 * $xn}]
      set rect_x2 [expr {$rect_x1 + 1}]
      set rect_y2 [expr {$rect_y1 + 1}]

      #puts "$rect_x1 $rect_y1 $rect_x2 $rect_y2"

      .f.diagram create line $rect_x1 $rect_y1 $rect_x2 $rect_y2 -tags dot

      set x1 $xn
    }
  }
}

proc redraw_diagram {} {
  global entry_iter 
  draw_diagram $entry_iter 
}

proc main {} {
  global entry_iter
  set entry_iter 150
  draw_gui
  draw_diagram $entry_iter 
}

main


