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
<!--    <script>
      jmolInitialize("../../../../jmol-12.0.19");
    </script>   --!>
    <table>
    <tr>
    <td><center><h2>Summary</h2></center></td>
    <td><center><h2>I(gamma) [eV]</h2></center></td>
<!--    <td><center><h2>Ediff [eV]</h2></center></td>
    <td><center><h2>J(gamma) [eV]</h2></center></td>
    <td><center><h2>HOMO [eV]</h2></center></td>   --!>
    </tr>
END

#      jmolSetAppletColor("#CCCCCC")
#      jmolApplet(640, 'load $directory/omega_opt/output.out; cpk 10%; wireframe .05; dots on; label "%e"');


#    <td>
#    <h2>"$directory"</h2>
#    <script>
#      jmolApplet(640, 'load $directory/omega_opt/output.out; cpk 10%; wireframe .05; dots off; set measurements angstroms; set defaultDistanceLabel "%10.4VALUE"; anim off;');
#    </script>
#    </td>

#foreach directory ( g2g71021 )

foreach directory ( g??????? )

  cat >> $html << END
  <tr>
    <td>
       <iframe width=800 height=640 src="$directory/summary.html"> </iframe>
    </td>
    <td>
    <img src="$directory/i.png">
    </td>
   <td>
<!--    <img src="$directory/Ediff.png">
    </td>
    <td>
    <img src="$directory/j.png">
    </td>
    <td>
    <img src="$directory/homo.png">
    </td>    --!>
</tr>
END
end

cat >> $html << END
      
    </table>
  </body>
</html>
END

