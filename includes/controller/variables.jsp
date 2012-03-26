<%-- 
    Document   : variables
    Created on : Nov 24, 2011, 7:49:48 PM
    Author     : fatih
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%! 
    public static String siteTitle = "Nicosia Games - Deal or No Deal";
    public static String loadingInfo = "Deal or No Deal yükleniyor";
    public static String pleaseWait = "Lütfen bekleyiniz";
    public static String quote = "NicoBank size 30 Bin TL teklif ediyor!";
    public static String selectNotification = "11 Numaralı kutuyu seçtiniz";
    public static String selection = "11";
    public static String boxLeft = "15 Kutunuz kaldı";
    public static Integer boxLim = 18;
    public static Integer[] boxArrayStart = {1,5,8,12,15};
    public static Integer[] boxArrayEnd = {4,7,11,14,18};
    public static Integer[] deposits = {10,20,50,100,200};
    public static Double depositRate = 0.1;
    public static String winners = "Kazananlar";
    public static String myBets = "Bahislerim";
    public static String testTable = "Oyunumuzu test etmek için aşağıdaki butonu tıklayarak 100 TL'lik bakiye yatırıp giriş yapabilirsiniz. Bu miktar sizin bakiyenizden düşülmeyecek ve kazandığınız rakam bakiyenize yatırılmayacaktır.";//"Test masamızda oynamak için giriş yapın.";
    public static String or = "veya";
    public static String chooseTable = "Gerçek bakiyeniz ile oynamak istiyorsanız lütfen aşağıdaki salonlarımızın birinde oynayın.";
    public static String balanceAmount = "Bakiye";
    public static String depositAmount = "Yatırılan";
    public static String declineOffer = "Yokum";
    public static String bankOffer = "NicoBank'ın teklifine<br/>Var mısın? Yok musun?";
    public static String acceptOffer = "Varım";
    public static String playAgain = "Oyunu başarıyla tamamladınız. Yeniden oynamak ister misiniz?";
    public static String acceptReplay = "Evet";
    public static String declineReplay = "Hayır";
    public static String username = "Kullanıcı Adı";
    public static String logOutMessage = "Oyunu 10 dakika içerisinde oyunu tamamlamadığınız için oyun iptal edilmiştir. Yatırdığınız tutar bakiyenize geri aktarılacaktır.<br>Lütfen oyunu 10 dakika içerisinde tamamlamaya özen gösteriniz.";
    public static String password = "Şifre";
    public static String loginNeed = "Oyuna giriş yapabilmek için üye girişi yapmanız gerekir!";
    public static String makeDeposit = "Lütfen oyuna giriş bakiyenizi belirtiniz";
    public static String depositError = "Oyuna giriş bakiyeniz minimum 10 maksimum 50 TL olmalıdır!";
    public static String balance = "Bakiyeniz";
    public static String loginError = "Giriş yapmaya çalışırken bir hata oluştu. Lütfen bilgilerinizi kontrol ederek tekrar deneyiniz!";
    public static String memberLogin = "Üye Girişi";
    public static String signin = "Giriş Yap";
    public static String emptyField = "Bu alan boş bırakılamaz!";
    public static String[] prices = {"0.1", "0.2", "0.5" , "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "20", "50", "100", "200", "250"};
    public static String[] titles = {"Bahis", "Yatırılan", "Kazanç","Üye No"};
%>
