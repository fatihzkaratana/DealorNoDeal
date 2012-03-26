<%-- 
    Document   : select
    Created on : Dec 30, 2011, 11:25:49 AM
    Author     : fatih
--%>

<%@page import="org.omg.CORBA.SystemException"%>
<%@page import="com.google.gson.*" %>
<%@ page import="java.io.*,java.util.*, java.text.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    String checknull(String xvalue) {
        return (xvalue == null) ? "" : xvalue;
    }

    String checknullzero(String xvalue) {
        return (xvalue == null) ? "0" : xvalue;
    }
    private String[] rates = new String(){""};/*{  "0.001",
                                "0.0020",
                                "0.0025",
                                "0.005",
                                "0.01",
                                "0.02",
                                "0.025",
                                "0.05",
                                "0.1",
                                "0.2",
                                "0.25",
                                "0.5",
                                "1",
                                "2",
                                "5",
                                "10",
                                "20",
                                "25"};*/
    private Integer index;
    private DecimalFormat df = new DecimalFormat("##.##");
    private String[] callback = {"deposit", "pick", "decline", "accept", "make"};
    private String callbackIndex;
    private String[] val;
    private Double newRate;
    public Gson gson = new Gson();
    public ArrayList<String> callbackKey = new ArrayList<String>();
    public ArrayList<Double> myRates = new ArrayList<Double>();
    public ArrayList<String> declineOffers = new ArrayList<String>();
    private String acceptedOffer;
    private Double newOffer;

    public Double _calculateOffer(ArrayList<Double> rateList, Integer offer){
        Double newOffer = 0.0;
        Double _avgTotal = 0.0;
        Double _avg = 0.0;
        Double min = Collections.min(rateList);
        Double max = Collections.max(rateList);
        try {
            //sum of list items
            for (Double i : rateList) {
                _avg += i;
            }/*
            for(Double i: rateList){
                _avgTotal += Math.pow(Math.abs(i - (_avg/rateList.size())),2);
            }*/
            //newOffer = (Math.sqrt(_avgTotal / rateList.size())) / ((max + min) / 2) * 100;
            //newOffer = (_avg / (rateList.size() * 2)) + (min / 2);
            if ( offer != 2 ) newOffer = (_avg/rateList.size()) * 0.20;
                       else newOffer = (_avg/4) + (min/2);
        } catch (Exception err) {
            System.out.print("Error occured on _calculateOffer: " + err);
        }
        return newOffer;
    }

    public void fillList(ArrayList list, String[] source) {
        try {
            if (list.isEmpty()) {
                if (list.size() > 0) {
                    list.clear();
                    for (int i = 0; i < source.length; i++) {
                        list.add(source[i]);
                    }
                } else {
                    for (int i = 0; i < source.length; i++) {
                        list.add(source[i]);
                    }
                }

            }
        } catch (SystemException err) {
            System.out.print("Error occured on fillList: " + err);
        }
    }

    public boolean checkExistingGame(String userid){
        
        return true;
    }
%>
<%
    try {
        callbackIndex = checknullzero(request.getParameter("option"));
        val = request.getParameter("value").split(" ");
        fillList(callbackKey, callback);

        switch (callbackKey.indexOf(callbackIndex)) {
            case 0: //deposit amount
                if (!(myRates.isEmpty())) {
                    myRates.clear();
                }
                if (!(declineOffers.isEmpty())) {
                    declineOffers.clear();
                }
                if ( val[0].equals("Dene")){
                    for (String i : rates) {
                        newRate = Double.parseDouble(i) * 100;
                        myRates.add(newRate);
                    }
                }else{
                    for (String i : rates) {
                        newRate = Double.parseDouble(i) * Double.parseDouble(val[0]);
                        myRates.add(newRate);
                    }
                }
                out.print(gson.toJson(myRates));
                break;
            case 1: //pick value
                index = Integer.parseInt(checknullzero(request.getParameter("selection")));
                index -= index;
                Collections.shuffle(myRates);
                out.print("{\"success\": \"true\", \"selection\": \"" + df.format(myRates.get(index)) + "\"}");
                myRates.remove(myRates.indexOf(myRates.get(index)));
                break;
            case 2: //decline offer
                String offer = checknullzero(request.getParameter("value"));
                String data = "{\"success\": \"true\", \"offeredDeclined\": \"" + true + "\"";
                if (declineOffers.size() != 0) {
                    data += ",\"values\": " + gson.toJson(declineOffers);
                } else {
                    data += ",\"values\": [0]";
                }
                data += "}";
                out.print(data);
                declineOffers.add(offer);
                break;
            case 3: //accept offer
                acceptedOffer = checknullzero(request.getParameter("value"));
                out.print("{\"success\": \"true\", \"offeredAccepted\": \"" + acceptedOffer + "\"}");
                break;
            case 4: //make offer
                Integer nextOffer = 0;
                if ( Integer.parseInt(val[0]) == 4 || Integer.parseInt(val[0]) == 8 || Integer.parseInt(val[0]) == 12 ){
                    nextOffer = 4;
                }else{
                    nextOffer = 2;
                }
                out.print("{\"success\": \"true\", \"offer\": \"" + df.format( _calculateOffer(myRates,nextOffer))  + "\", \"nextOffer\":\""+nextOffer+"\"}");
                break;
            default:
                out.print("There is nothing to send!");
                break;
        }
    } catch (Exception err) {
        out.println("Error occured on main: " + err );
    }
%>