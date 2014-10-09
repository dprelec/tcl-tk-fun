# vim:shiftwidth=2
# vim:tabstop=2

# sierpinski carpet fractal
# dprelec, 2010-03-24

package require Tk

proc calc_rect_coords {dx dy d} {
  set coords [list]
  foreach i {0 1 2} {
    foreach j {0 1 2} {
      set x [expr {$dx+($i*$d)}]
      set y [expr {$dy+($j*$d)}]
      lappend coords [list $x $y]
    }
  }
  return "[lrange $coords 0 3] [lrange $coords 5 8]"
}

proc draw_rect {dx dy d} {
  .c create rectangle [expr {$dx+$d}] [expr {$dy+$d}] [expr {$dx+2*$d}] \
    [expr {$dy+2*$d}] -fill yellow  
}

proc draw_fractal {width start} {
  set dx [lindex $start 0]
  set dy [lindex $start 1]
  set d [expr $width/3]
  draw_rect $dx $dy $d
  return [calc_rect_coords $dx $dy $d]
}

proc main {width} {
  pack [canvas .c -width $width -height $width]
  bind . <Escape> exit
  set coords [draw_fractal $width {0 0}]
  foreach r {1 2 3 4} {
    set width [expr $width/3]
    set new [list]
    foreach c $coords {lappend new [draw_fractal $width $c]}
    set coords [join $new]
  }
}

main 500



