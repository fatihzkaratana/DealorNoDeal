<script type="text/javascript" src="assets/js/jquery.backgroundPosition.js"></script>
</head>
<body id="DealnoDeal" class="game">
    <div id="wrapper">
        <div id="overlay">
            <div id="loader">
                <h1><%= loadingInfo%></h1>
                <label id="loadCounter"></label>
                <h1><%= pleaseWait%></h1>
            </div>
        </div>
        <div id="close">
            <a href="#" onclick="window.close();" title=""></a>
        </div>
        <div id="gameInfo">
            <h3 id="gameId"></h3>
        </div>
        <div id="timer">
            10:00
        </div>
        <div id="logo">
            <a href="#" title="">
                <h1 title=""></h1>
            </a>
            <div class="clr"></div>
        </div>
        <div id="container">
            <div id="depositBox" class="modal">
                <form name="formDeposit" id="formDeposit" enctype="multipart/form-data" method="POST" accept-charset="utf-8">
                    <div id="depositTables">
                        <h1><%= chooseTable%></h1>
                        <% try {
                                Integer j = 2;
                                for (int i : deposits) {%>
                        <input type="button" name="deposit-<%= i%>" class="button" id="<%= j%>" value="<%= i%>" />
                        <% j++;
                                }
                            } catch (Exception e) {
                                System.out.print(e);
                            }%>
                    </div>
                    <div id="testTables">
                        <h1><%= testTable%></h1>
                        <input type="button" name="depositTest" id="1" class="button" value="100" />
                    </div>
                </form>
            </div>
            <div id="offerBox" class="modal">
                <form name="formOffer" id="formOffer" enctype="multipart/form-data" method="POST" accept-charset="utf-8">
                    <h1><%= bankOffer%></h1>
                    <h3 id="bankOfferVal"></h3>
                    <div class="offerButtons">
                        <input type="button" class="button" name="acceptOffer" id="acceptOffer" value="<%= acceptOffer%>" />
                        <input type="button" class="button" name="declineOffer" id="declineOffer" value="<%= declineOffer%>" />
                    </div>
                </form>
            </div>
            <div id="acceptBox" class="modal">
                <h1><%= playAgain%></h1>
                <form name="formAccept" id="formAccept" enctype="multipart/form-data" method="POST" accept-charset="utf-8">    
                    <div class="offerButtons">
                        <input type="button" class="button" name="playGame" id="acceptReplay" value="<%= acceptReplay %>" />
                        <input type="button" class="button" name="leaveGame" id="declineReplay" value="<%= declineReplay %>" />
                    </div>
                </form>
            </div>
            <div id="logoutBox" class="modal">
                <h1><%= logOutMessage%></h1>
            </div>
            <div id="left" class="coloumn">
                <ul id="leftNumbers" class="numbers">
                    <% try {
                            for (int i = 0; i < (prices.length / 2); i++) {%>
                    <li class="item" id="number-<%= i%>">
                        <h3 id="price-<%= i%>" class="price"></h3>
                    </li>
                    <%  }
                        } catch (Exception e) {
                            System.out.print(e);
                        }
                    %>
                    <li class="clr"></li>
                </ul>
            </div>
            <div id="openBoxWrapper" class="modal">
                <div id="openBox">
                    <div id="cover">
                        <h3></h3>
                    </div>
                    <h3 id="boxNumber"></h3>
                </div>
            </div>
            <div id="boxWrapper">
                <% try {
                        for (int i = 0; i <= 4; i++) {
                %>
                <div id="boxList<%= i%>" class="boxes">
                    <% try {
                            for (int j = boxArrayStart[i]; j <= boxArrayEnd[i]; j++) {%>
                    <div class="box active" id="box-<%= j%>">
                        <a href="#" id="number-<%= j%>"><%= j%></a>
                    </div>
                    <%  }
                        } catch (Exception e) {
                            System.out.print(e);
                        }
                    %>
                    <div class="clr"></div>
                </div>
                <%    }
                    } catch (Exception e) {
                        System.out.print(e);
                    }
                %>
            </div>
            <div id="right" class="coloumn">
                <ul id="rightNumbers" class="numbers">
                    <% try {
                            for (int i = 9; i < prices.length; i++) {%>
                    <li class="item" id="number-<%= i%>">
                        <h3 id="price-<%= i%>" class="price"></h3>
                    </li>
                    <%  }
                        } catch (Exception e) {
                            System.out.print(e);
                        }
                    %>
                    <li class="clr"></li>
                </ul>
            </div>
            <div class="clr"></div>
        </div>
        <div id="bottom">
            <div id="notificationBar" class="bar">
                <div id="leftPart" class="text">
                    <h3><%= quote%></h3>
                </div>
            </div>
            <div id="selectionBar" class="bar">
                <div id="rightPart">
                    <div id="selectNotification" class="content">
                        <h3></h3>
                    </div>
                    <div id="seperator" class="content"></div>
                    <div id="boxLeft" class="content">
                        <h3></h3>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <div id="selectedBox" class="box">
                <h3 id="selection"><%= selection%></h3>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function(){
            $.startGame();
        });
    </script>
</body>