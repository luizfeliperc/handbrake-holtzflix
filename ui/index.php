<!doctype html>
<html>
<meta http-equiv="refresh" content="10" charset="UTF-8"/>
<meta name="robots" content="noindex" content="nofollow” />
<meta http-equiv="Cache-Control" content="no-cache">
<meta name="copyright" content="pgblitz.com" />
<title>HoltzBlitz - Monitor de Upload</title>
<meta name="viewport" content="width=device-width, initial-scale=0.5">
<link rel="icon" type="image/png" href="https://i.ibb.co/D8K57Vj/1200px-Google-Drive-icon-2020-svg.png" sizes="32x32">
<style type="text/css">
body {
	background-color: #2E2E2E;
	text-align: left;
}
.test {
}
body,td,th {
	color: #FFFFFF;
	font-size: 16px;
	font-family: Segoe, "Segoe UI", "DejaVu Sans", "Trebuchet MS", Verdana, sans-serif;
}
a:link {
	color: #E8DD06;
}
a:visited {
	color: #E8DD06;
}
div {
  width: 100%;
  height: 100%;
  background-image: -webkit-linear-gradient(rgba(255, 255, 255, 0), rgba(255, 255, 255, 0)), url('https://i.ibb.co/R6J7HrM/teste2.png');
  background-size: 100% 100%;
}
</style>
</head>
<body text="#FFFFFF">
<div>
<table width="100%" border="0" cellpadding="5" cellspacing="0">
  <tbody>
    <tr>
      <td width="100">&nbsp;</td>
		<td width="100%" align="center">
			<h1>
				<strong style="color: #FFFFFF; font-family: Calibri; font-size: 48px; font-weight: bolder;">HandBrake - Monitor de Upload<br>
					<span style="color: #A9A9A9; font-size: 18px">As informações são atualizadas a cada 30 segundos</span>	
					<br>
				</strong>
			</h1>
		</td>
    </tr>
  </tbody>
</table>
</div>
<br>
<table width="100%" height="44" border="1" align="center" cellpadding="5" cellspacing="0">
          <tbody>
            <tr>
              <td colspan="6" bgcolor="#000000" style="color: #F7F6F6; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-weight: bold; font-size: medium;"><span class="test" style="color: #FFFFFF; font-family: Segoe, 'Segoe UI', 'DejaVu Sans', 'Trebuchet MS', Verdana, sans-serif; font-size: medium;">
                <?php $output = shell_exec('tail -n 35 /log/*.log | sed -e "/HoltzBlitz Log - Cycle/q"');
echo "<pre>$output</pre>";
?>
              </span></td>
            </tr>
          </tbody>
        </table>
</table>
</body>
</html>
