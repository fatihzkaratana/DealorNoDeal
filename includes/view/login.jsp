<link rel="stylesheet" type="text/css" href="assets/css/other.css" />
<script type="text/javascript" src="assets/js/login.js"></script>
</head>
<body id="login" class="game">
    <div id="wrapper" class="login">
        <div id="overlay"></div>
        <div id="login-wrapper" class="png_bg">
            <div id="close">
                <a href="#" onclick="window.close();" title=""></a>
            </div>
            <div id="logo">
                <a href="#" title="">
                    <h1 title=""></h1>
                </a>
                <div class="clr"></div>
            </div>
            <div id="login-content">
                <form name="formLogin" id="formLogin" enctype="multipart/form-data" method="POST" accept-charset="utf-8">
                    <div id="notification" class="notification information png_bg">
                        <div>
                            <%= loginNeed%>
                        </div>
                    </div>
                    <div id="error" class="notification error png_bg">
                        <div>
                            <%= loginError%>
                        </div>
                    </div>
                    <p>
                        <label><%= username%></label>
                        <input name="username" id="username" class="text-input" type="text" />
                    </p>
                    <div class="clear"></div>
                    <p>
                        <label><%= password%></label>
                        <input name="password" id="password" class="text-input" type="password" />
                    </p>
                    <div class="clear"></div>
                    <p>
                        <input class="button" type="submit" value="<%= signin%>">
                    </p>
                </form>
            </div> <!-- End #login-content -->
        </div> <!-- End #login-wrapper -->
    </div>
</body>