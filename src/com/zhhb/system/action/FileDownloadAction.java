package com.zhhb.system.action;

import java.io.BufferedInputStream;  
import java.io.BufferedOutputStream;  
import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStream;  
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;  

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;  

import org.apache.batik.apps.rasterizer.Main;
import org.apache.log4j.Logger;  
import org.apache.struts2.ServletActionContext;  
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;  
import com.pintu.pub.action.BaseAction;

import java.io.*;  
import java.text.SimpleDateFormat;
import java.util.Date;  
import java.util.Properties;
import java.util.Random;
import java.util.UUID;
import java.util.zip.GZIPInputStream;
import java.awt.*;  
import java.awt.image.*;  

import javax.annotation.Resource;
import javax.imageio.ImageIO;  
import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sun.image.codec.jpeg.*;  
import com.zhhb.server.comm.PublicJdbcDao;




@SuppressWarnings({ "unused", "unchecked", "serial" })
@Scope("prototype")
@Controller(value = "fileDownloadAction")
public class FileDownloadAction extends  BaseAction {   
	@Resource
	private PublicJdbcDao psychologyJdbcDao;
	
	public PublicJdbcDao getPsychologyJdbcDao() {
		return psychologyJdbcDao;
	}

	public void setPsychologyJdbcDao(PublicJdbcDao psychologyJdbcDao) {
		this.psychologyJdbcDao = psychologyJdbcDao;
	}
	
	
	
		private Logger Log = Logger.getLogger(FileDownloadAction.class);  
	    private static final String FilePath = "E:\\";  
	    private static final long serialVersionUID = -8694640030455344419L;  
		private final static String YX_NAME="zhaoliangjava@126.com";//邮箱登陆名
		private final static String YX_PWD="24384530363";//邮箱登陆密码
		private final static String YX_SMTP="smtp.126.com";//邮箱smtp
		
		//本地多文件下载开始
	    public String execute() {  
	    	String pathurl=this.request.getParameter("pathurl");
	        //生成的ZIP文件名为Demo.zip  
	        String tmpFileName = "Demo.zip";  
	        byte[] buffer = new byte[1024];  
	        String strZipPath = FilePath + tmpFileName;  
	        try {  
	            ZipOutputStream out = new ZipOutputStream(new FileOutputStream(  
	                    strZipPath));  
	            // 需要同时下载的两个文件result.txt ，source.txt  
	            String[] url=pathurl.split(",");
	            File[] file1 = null;
	            for(int j=0;j<url.length;j++){
	            	File[] fileurl={new File(FilePath+url[j])};
	            	file1=fileurl;
	            	 File[] file3= { new File(FilePath+"psychologydb原版.sql"),new File(FilePath+"tekumadb.sql") };  
	            	for (int i = 0; i < file1.length; i++) {  
	            		if(!file1[i].exists()){
	            			file1[i].createNewFile();
	            		}
		                FileInputStream fis = new FileInputStream(file1[i]);  
		                out.putNextEntry(new ZipEntry(file1[i].getName()));  
		                //设置压缩文件内的字符编码，不然会变成乱码  
		                out.setEncoding("GBK");  
		                int len;  
		                // 读入需要下载的文件的内容，打包到zip文件  
		                while ((len = fis.read(buffer)) > 0) {  
		                    out.write(buffer, 0, len);  
		                }  
		                out.closeEntry();  
		                fis.close();  
		            } 
	            }
	            out.close();  
	            this.downFile(getResponse(), tmpFileName);  
	        } catch (Exception e) {  
	            Log.error("文件下载出错", e);  
	        }  
	        return null;  
	    }  
	  
	    /** 
	     * 获取Response 
	     * @return 
	     */  
	    private HttpServletResponse getResponse() {  
	        return ServletActionContext.getResponse();  
	    }  
	  
	    /** 
	     * 文件下载 
	     * @param response 
	     * @param str 
	     */  
	    private void downFile(HttpServletResponse response, String str) {  
	        try {  
	            String path = FilePath + str;  
	            File file = new File(path);  
	            if (file.exists()) {  
	                InputStream ins = new FileInputStream(path);  
	                BufferedInputStream bins = new BufferedInputStream(ins);// 放到缓冲流里面  
	                OutputStream outs = response.getOutputStream();// 获取文件输出IO流  
	                BufferedOutputStream bouts = new BufferedOutputStream(outs);  
	                response.setContentType("application/x-download");// 设置response内容的类型  
	                response.setHeader(  
	                        "Content-disposition",  
	                        "attachment;filename="  
	                                + URLEncoder.encode(str, "UTF-8"));// 设置头部信息  
	                int bytesRead = 0;  
	                byte[] buffer = new byte[8192];  
	                // 开始向网络传输文件流  
	                while ((bytesRead = bins.read(buffer, 0, 8192)) != -1) {  
	                    bouts.write(buffer, 0, bytesRead);  
	                }  
	                bouts.flush();// 这里一定要调用flush()方法  
	                ins.close();  
	                bins.close();  
	                outs.close();  
	                bouts.close();  
	            } else {  
	                response.sendRedirect("../error.jsp");  
	            }  
	        } catch (IOException e) {  
	            Log.error("文件下载出错", e);  
	        }  
	    }  
//多文件下载结束
	    
	    
	    
	    /*//图片压缩
	    private Image img;  
	    private int width;  
	    private int height;  
	    @SuppressWarnings("deprecation")  
	    public static void main(String[] args) throws Exception {  
	        System.out.println("开始：" + new Date().toLocaleString());  
	        FileDownloadAction imgCom = new FileDownloadAction("F:\\temp\\gaoqing.jpg");  
	        imgCom.resizeFix(400, 400);  
	        System.out.println("结束：" + new Date().toLocaleString());  
	    }  
	    *//** 
	     * 构造函数 
	     *//*  
	    public FileDownloadAction(String fileName) throws IOException {  
	        File file = new File(fileName);// 读入文件  
	        img = ImageIO.read(file);      // 构造Image对象  
	        width = img.getWidth(null);    // 得到源图宽  
	        height = img.getHeight(null);  // 得到源图长  
	    }  
	    *//** 
	     * 按照宽度还是高度进行压缩 
	     * @param w int 最大宽度 
	     * @param h int 最大高度 
	     *//*  
	    public void resizeFix(int w, int h) throws IOException {  
	        if (width / height > w / h) {  
	            resizeByWidth(w);  
	        } else {  
	            resizeByHeight(h);  
	        }  
	    }  
	    *//** 
	     * 以宽度为基准，等比例放缩图片 
	     * @param w int 新宽度 
	     *//*  
	    public void resizeByWidth(int w) throws IOException {  
	        int h = (int) (height * w / width);  
	        resize(w, h);  
	    }  
	    *//** 
	     * 以高度为基准，等比例缩放图片 
	     * @param h int 新高度 
	     *//*  
	    public void resizeByHeight(int h) throws IOException {  
	        int w = (int) (width * h / height);  
	        resize(w, h);  
	    }  
	    *//** 
	     * 强制压缩/放大图片到固定的大小 
	     * @param w int 新宽度 
	     * @param h int 新高度 
	     *//*  
	    public void resize(int w, int h) throws IOException {  
	        // SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢  
	        BufferedImage image = new BufferedImage(w, h,BufferedImage.TYPE_INT_RGB );   
	        image.getGraphics().drawImage(img, 0, 0, w, h, null); // 绘制缩小后的图  
	        UUID uuid = UUID.randomUUID(); 
	        String file="F:\\temp\\"+uuid+".jpg";
	        File destFile = new File(file);  
	        FileOutputStream out = new FileOutputStream(destFile); // 输出到文件流  
	        // 可以正常实现bmp、png、gif转jpg  
	        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);  
	        encoder.encode(image); // JPEG编码  
	        out.close();  
	    }  
	    //图片压缩结束
  */
	   
	   
	    //远程图片下载(单文件)
	    public  void download()throws Exception {
	    		 // 构造URL
	    		String urlString=this.request.getParameter("urlString");
	    		String filename=this.request.getParameter("filename");
	    		int index = filename.indexOf("/");
	    		String left = filename.substring(0,index);
	    		String right = filename.substring(index);
	    		/*String fname="E://tp/";
	    		File name=new File(fname+left);
	    		if(!name.exists()){
	    			name.mkdir();
	    		}*/ 
	    		OutputStream outs = response.getOutputStream();// 获取文件输出IO流  
	            BufferedOutputStream bouts = new BufferedOutputStream(outs);  
	            response.setContentType("application/x-download");// 设置response内容的类型  
                response.setHeader(  
                        "Content-disposition",  
                        "attachment;filename="  
                                + URLEncoder.encode(right, "UTF-8"));
	  
	    		  URL url = new URL(urlString);
	    		  // 打开连接
	    		  HttpURLConnection con = (HttpURLConnection) url.openConnection();
	    		  //URLConnection con = url.openConnection();
	    		  con.setDoInput(true);//设置是否要从 URL 连接读取数据,默认为true  
	    		  con.connect();  
	    		  // 输入流
	    		  InputStream is = con.getInputStream();
	    		  String code=con.getHeaderField("Content-Encoding");
	    		  //System.out.println("cdoe:"+code);
	    		  if ((null!=code)&& code.equals("gzip"))
	    		  {
	    		   GZIPInputStream gis = new GZIPInputStream(is);
	    		   // 1K的数据缓冲
	    		   byte[] bs = new byte[8192];
	    		   // 读取到的数据长度
	    		   int len;
	    		   // 输出的文件流
	    		   //OutputStream os = new FileOutputStream(fname+filename);
	    		   // 开始读取
	    		   while ((len = gis.read(bs)) != -1) {
	    		    //os.write(bs, 0, len);
	    		    bouts.write(bs, 0, len);  
	    		   }
	    		   // 完毕，关闭所有链接
	    		   bouts.flush();
	    		   gis.close();
	    		   //os.close();
	    		   is.close();
	    		  }
	    		  else
	    		  {
	    		   // 1K的数据缓冲
	    		   byte[] bs = new byte[8192];
	    		   // 读取到的数据长度
	    		   int len;
	    		   // 输出的文件流
	    		   //OutputStream os = new FileOutputStream(fname+filename);
	    		   // 开始读取
	    		   while ((len = is.read(bs)) != -1) {
	    		    //os.write(bs, 0, len);
	    		    bouts.write(bs, 0, len);  
	    		   }
	    		   // 完毕，关闭所有链接
	    		   bouts.flush();
	    		   //os.close();
	    		   is.close();
	    		  }
	    }
	    
		 /* public static void main(String[] args) throws Exception {  
			  download("http://192.168.31.111:8080/tup/1/182.jpg","E://project/tup/WebContent/dplw.jpg");
	
		  }*/
	    
	    
	    
	  //远程图片下载(多文件)
	    public  void  downloadlist() throws Exception {  
	    	
	    		String urlString =this.request.getParameter("urlString");
	    		
		        // 构造URL  
	    		String tmpFileName = "D:\\project\\TekumaServer\\Demo.zip"; 
		       
		        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(tmpFileName));  
		        String[] furl=urlString.split(",");

	            for(int j=0;j<furl.length;j++){
	            	
	            	URL url = new URL(furl[j]);  
			        // 打开连接  
			        URLConnection con = url.openConnection();  
			        //设置请求超时为10s  
			        con.setConnectTimeout(10000);  
			        
			        // 输入流  
			        InputStream fis = con.getInputStream();  
			        
			        String nrar=furl[j];
			        String name=nrar.substring(nrar.lastIndexOf("/")+1);
			        
	                out.putNextEntry(new ZipEntry(name));  
	                //设置压缩文件内的字符编码，不然会变成乱码  
	                out.setEncoding("GBK");  
	                int len=0;  
	                byte[] buffer = new byte[1024];
	                // 读入需要下载的文件的内容，打包到zip文件  
	                while ((len = fis.read(buffer)) > 0) {  
	                    out.write(buffer, 0, len);  
	                }  
	                out.closeEntry();  
	                fis.close();  
	            }
	            out.close();
	            File file = new File(tmpFileName);
	            InputStream ins = new FileInputStream(file);  
                BufferedInputStream bins = new BufferedInputStream(ins);// 放到缓冲流里面  
                OutputStream outs = response.getOutputStream();// 获取文件输出IO流  
                BufferedOutputStream bouts = new BufferedOutputStream(outs);  
                response.setContentType("application/x-download");// 设置response内容的类型  
                response.setHeader(  
                        "Content-disposition",  
                        "attachment;filename="  
                                + URLEncoder.encode("Demo.zip", "UTF-8"));// 设置头部信息  
                int bytesRead = 0;  
                byte[] buffer = new byte[1024];  
                // 开始向网络传输文件流  
                while ((bytesRead = bins.read(buffer, 0, 1024)) >0) {  
                    bouts.write(buffer, 0, bytesRead);  
                }  
                bouts.flush();// 这里一定要调用flush()方法  
                ins.close();  
                bins.close();  
                outs.close();  
                bouts.close();  
		    }   
	    
	    

	    
	    //远程文本下载
	    /*public void DownAndReadFile(){  
	    	String filePath=this.request.getParameter("filepath");
	        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());      
	        File savePath = new File("D://"+date);//创建新文件  
	        if (!savePath.exists()) {   
	            savePath.mkdir();   
	        }  
	        String[] urlname = filePath.split("/");  
	        int len = urlname.length-1;  
	        String uname = urlname[len];//获取文件名  
	        try {  
	            File file = new File(savePath+"//"+uname);//创建新文件  
	            if(file!=null && !file.exists()){  
	                file.createNewFile();  
	            }  
	            
	            OutputStream oputstream = new FileOutputStream(file);  
	            
	            response.setContentType("application/x-download");// 设置response内容的类型  
                response.setHeader(  
                        "Content-disposition",  
                        "attachment;filename="  
                                + URLEncoder.encode(filePath, "UTF-8"));
	            
	            URL url = new URL(filePath);  
	            HttpURLConnection uc = (HttpURLConnection) url.openConnection();  
	            uc.setDoInput(true);//设置是否要从 URL 连接读取数据,默认为true  
	            uc.connect();  
	            InputStream iputstream = uc.getInputStream();  
	            System.out.println("file size is:"+uc.getContentLength());//打印文件长度  
	            byte[] buffer = new byte[4*1024];  
	            int byteRead = -1;     
	            while((byteRead=(iputstream.read(buffer)))!= -1){  
	                oputstream.write(buffer, 0, byteRead);  
	            }  
	            oputstream.flush();    
	            iputstream.close();  
	            oputstream.close();  
	            //读取文件  
	            StringBuffer strb = new StringBuffer();  
	            FileInputStream fs = new FileInputStream(new File(savePath+"//"+uname));  
	            InputStreamReader isr = new InputStreamReader(fs,"UTF-8");  
	            BufferedReader br = new BufferedReader(isr);  
	            String data = "";  
	            while((data = br.readLine()) != null){  
	                strb.append(data + "\n");  
	            }  
	            br.close();  
	            fs.close();  
	            isr.close();  
	            System.out.println(strb.toString());         
	     } catch (Exception e) {  
	         System.out.println("读取失败！");     
	     }     
	   }*/
	    
	    
	    
	    
	   //邮件发送
	    public void sendMail() throws ServletException, IOException{
	    	String userName = YX_NAME;  
            String password = YX_PWD;  
	        String toMail = request.getParameter("email");  
	        String code = request.getParameter("code");
	        this.psychologyJdbcDao.executeSQL("insert into tk_code_t(NUMBER,EMAIL) values('"+code+"','"+toMail+"')");
            Properties props = new Properties();   
            props.setProperty("mail.smtp.host", toMail);  
            props.setProperty("mail.smtp.auth", "true");  
            javax.mail.Authenticator authenticator = new MyAuthenticator(userName, password);  
            javax.mail.Session session = javax.mail.Session.getDefaultInstance(props,authenticator);  
            session.setDebug(true);  
            try{  
                InternetAddress from = new InternetAddress(userName);  
                InternetAddress to = new InternetAddress(toMail);  
                MimeMessage msg = new MimeMessage(session);  
                msg.setFrom(from);  
                msg.setSubject("TEKUMA");  
                msg.setSentDate(new Date());  
                msg.setContent("Hello,Now invite you to experience the tekuma art platform, the invitation code is: "+code+"", "text/html;charset=utf-8");  
                msg.setRecipient(RecipientType.TO, to);  
                Transport transport = session.getTransport("smtp"); 
                transport.connect(YX_SMTP, userName, password); 
                transport.sendMessage(msg,msg.getAllRecipients()); 
                transport.close(); 
                Transport.send(msg);  
            } catch(MessagingException e){  
                e.printStackTrace();  
            }  
		}
	    
	    
	    
	    
	    
	    
}
class MyAuthenticator extends Authenticator {  
    private String userName;  
    private String password;  
  
    public MyAuthenticator(String userName, String password){  
        this.userName = userName;  
        this.password = password;  
    }  
  
    @Override  
    protected PasswordAuthentication getPasswordAuthentication() {  
        return new PasswordAuthentication(userName, password);  
    }  
    
    
    
}
