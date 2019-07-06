package com.nieyue.util;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.*;

/**
 * liunx工具集
 */
public class LiunxUtil {
    public static String getgateway()
    {

        String[] cmd = new String[] { "/bin/sh","-c", "route | grep -P \"^default.*eth0$\" | awk '{print $2}'" };
        String gateway = null;
        Process process;
        try {
            process = Runtime.getRuntime().exec(cmd);
            InputStreamReader r = new InputStreamReader(process.getInputStream());
            LineNumberReader returnData = new LineNumberReader(r);
            gateway = returnData.readLine();
            System.out.println(gateway);
        } catch (IOException ex) {}

        return gateway;
    }
    //获取网卡信息
    public static  List<Map<String,String>> getNetworkInterfaces() throws SocketException {
        List<Map<String,String>> list=new ArrayList<>();
        // 获得本机的所有网络接口
        Enumeration<NetworkInterface> nifs = NetworkInterface.getNetworkInterfaces();
        while (nifs.hasMoreElements()) {
            NetworkInterface nif = nifs.nextElement();
            // 获得与该网络接口绑定的 IP 地址，一般只有一个
            Enumeration<InetAddress> addresses = nif.getInetAddresses();
            while (addresses.hasMoreElements()) {
                InetAddress addr = addresses.nextElement();
                if (addr instanceof Inet4Address) { // 只关心 IPv4 地址
                    Map<String,String> map=new HashMap<>();
                    map.put("name",nif.getName());
                    map.put("hostAddress",addr.getHostAddress());
                    list.add(map);
                   // System.out.println("网卡接口名称：" + nif.getName());
                   // System.out.println("网卡接口地址：" + addr.getHostAddress());
                   // System.out.println();
                }
            }
        }
        return list;
    }
    public static void main(String[] args) throws SocketException {
        System.out.println(LiunxUtil.getNetworkInterfaces());
    }
}
