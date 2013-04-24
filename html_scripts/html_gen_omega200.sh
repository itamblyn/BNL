#!/bin/tcsh

set name=`pwd | sed s/"\/"/" "/g | awk '{print $NF}'`

set html="index.html"

cat > $html << END
<html>
  <head>

    <title>$name</title>
    <script src="../../../../jmol-12.0.19/Jmol.js"></script>
  </head>
  <body>
  <center>Return to <a href="../index.html">index</a></center>
    <script>
      jmolInitialize("../../../../jmol-12.0.19");
    </script>
    <table>
END

#      jmolSetAppletColor("#CCCCCC")
#      jmolApplet(640, 'load $directory/omega_opt/output.out; cpk 10%; wireframe .05; dots on; label "%e"');

#foreach directory ( g2g71000 )

foreach directory ( g??????? )

  cat >> $html << END
  <tr>
    <td>
       <iframe width=800 height=640 src="$directory/omega_opt/summary.html"> </iframe>
    </td>
    <td>
    <h2>"$directory"</h2>
    <script>
      jmolApplet(640, 'load $directory/omega200/output.out; cpk 10%; wireframe .05; dots off; set measurements angstroms; set defaultDistanceLabel "%10.4VALUE"; anim on;');
    </script>
    </td>
    <td>
    <img src="$directory/j.png">
    </td>
    <td>
    <img src="$directory/Ediff.png">
    </td>
    <td>
    <img src="$directory/i.png">
    </td>
    <td>
    <img src="$directory/homo.png">
    </td>  
</tr>
END
end

cat >> $html << END
      
    </table>
  </body>
</html>
END

