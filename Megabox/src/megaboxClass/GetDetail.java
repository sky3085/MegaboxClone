package megaboxClass;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

import javax.imageio.ImageIO;

import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class GetDetail {

	MovieDTO movielist = new MovieDTO();

	private int Max = 10;
	private String DRIVER_ID = "webdriver.chrome.driver"; // chromedriver 사용
	//private String DRIVER_PATH = "C://Users//Moon//eclipse-workspace//portfolio_movie//portfolio_movie//Megabox//WebContent//WEB-INF//libs//chromedriver.exe";
	private String DRIVER_PATH="/Users/jina/git/MegaboxClone/Megabox/WebContent/WEB-INF/libs/chromedriver";
	private String realpath = "poster"; // 디비에 저장될 상대 경로
	private String path = "/Users/jina/git/MegaboxClone/Megabox/WebContent/poster";// 절대 경로로 저장
//	private String path = "C://Users//Moon//eclipse-workspace//portfolio_movie//portfolio_movie//Megabox//WebContent//poster";
	private String url = "";// 정보 가져올 영화 링크
	private int i = 0;
	//private List<MovieDTO> movieList;

	public GetDetail(String url, int i) {
		this.url = url;
		this.i = i;
		//this.movieList = movieList;
	}

	public void Crawling() {
		System.setProperty(DRIVER_ID, DRIVER_PATH);
		WebDriver driver = new ChromeDriver();

		// 파일 저장경로 생성
		File Folder = new File(path);
		if (!Folder.exists()) {
			try {
				Folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		try {
			/* 널값으로 생성해서 오류방지 */
			movielist.setMovieActors("null");
			movielist.setMovieAge("null");
			movielist.setMovieDirector("null");
			movielist.setMovieTitle("null");
			movielist.setMovieRank("null");
			movielist.setMovieNum("null");
			movielist.setMovieSummary("null");
			movielist.setMovieType("null");
			movielist.setMovieActors("null");
			movielist.setMovieGenre("null");
			movielist.setMovieAge("null");
			movielist.setMovieRelease("null");
			movielist.setMovieImg("null");
			movielist.setMovieVideo("null");

			driver.get(url);
			
			//감독, 장르, 등급, 개봉일 
			List<WebElement> line =driver.findElements(By.cssSelector(".line p"));
			for(WebElement e :line) {
				String rs=e.getText().substring(0,2);
				switch(rs) {
				case "감독":
					System.out.println(e.getText().substring(5));
					movielist.setMovieDirector(e.getText().substring(5));
					break;
				case "장르":
					System.out.println(e.getText().substring(5));
					movielist.setMovieGenre(e.getText().substring(5));
					break;
				case "등급":
					String rate=e.getText().substring(5, 7);
					System.out.println(rate);
					if (rate.equals("청소"))
						movielist.setMovieAge("청불");
					movielist.setMovieAge(rate);
					break;
				case "개봉":
					System.out.println(e.getText().substring(6));
					movielist.setMovieRelease(e.getText().substring(6));
					break;
				}
			}
			
			// 제목
			try {
			WebElement title = driver.findElement(By.cssSelector("div.movie-detail-cont>p.title"));
			movielist.setMovieTitle(title.getText());
			System.out.println(title.getText());
			}catch (NoSuchElementException e) {
				System.out.println("제목없음");
				movielist.setMovieTitle("null");
			}
			// 순위
			try {
			String rate=String.valueOf(i);
			movielist.setMovieRank(rate);
			/*박스오피스 순위 실시간으로 반영을 못함. -> idx 값으로 수정 */
			/*
			 * WebElement rate = driver.findElement(By.cssSelector("div.rate>p.cont>em"));// 순위
			 * System.out.println(rate.getText());
			 * movielist.setMovieRank(rate.getText());
			 */
			}catch (NoSuchElementException e) {
				System.out.println("순위 없음");
				movielist.setMovieRank("null");
			}
			// 누적관객
			try {
			List<WebElement> audience = driver.findElements(By.cssSelector("div.audience>p>em"));// 누적관객수
			for (WebElement e : audience) {
				System.out.println(e.getText());
				movielist.setMovieNum(e.getText().replaceAll(",", ""));
			}}catch (NoSuchElementException e) {
				System.out.println("누적관객 없음");
				movielist.setMovieNum("null");
			}

			Thread.sleep(2000);
			// 줄거리
			try {
			WebElement summary = driver.findElement(By.cssSelector("#info>div.txt"));// 줄거리
			System.out.println(summary.getText());
			movielist.setMovieSummary(summary.getText());}
			catch (NoSuchElementException e) {
				System.out.println("줄거리 없음");
				movielist.setMovieSummary("null");
			}
			
			// 영화타입
			try {
			WebElement movietype = driver.findElement(By.cssSelector("div.movie-info.infoContent>p:nth-child(1)"));// 영화타입
			System.out.println(movietype.getText());
			movielist.setMovieType(movietype.getText().substring(7));}
			catch (NoSuchElementException e) {
				System.out.println("영화타입 없음");
				movielist.setMovieType("null");
			}
			// 배우 
			try {
				WebElement actor = driver.findElement(By.cssSelector("div.movie-info.infoContent>p:nth-child(3)"));// 배우
				System.out.println(actor.getSize());
				System.out.println(actor.getText());
				movielist.setMovieActors(actor.getText().substring(5));
			} catch (NoSuchElementException e) {
				System.out.println("배우없음");
				movielist.setMovieActors("null");
			}
			
			// 썸네일//
			Thread.sleep(5000);
			try {
				WebElement preview = driver.findElement(By.cssSelector("div.tab-list.fixed>ul>li:nth-child(4)"));
	
				preview.click();// 예고편 버튼 클릭
				Thread.sleep(2000);
				List<WebElement> thumnails = driver.findElements(By.cssSelector("div.stair-slide-list>div.thumb>a>img"));
				String photoPath = "";
				int j = 0;
				for (WebElement e : thumnails) {
					String thumURL = e.getAttribute("src");
					URL imageURL = new URL(thumURL);
					BufferedImage saveImage = ImageIO.read(imageURL);
					photoPath += realpath + "/thum" + movielist.getMovieRank() + "_" + j + ".png,";
					ImageIO.write(saveImage, "png", new File(path + "/thum" + movielist.getMovieRank() + "_" + j + ".png"));
					j++;
					if (j == Max)
						break;
				}
				System.out.println(photoPath);
				movielist.setMovieImg(photoPath);
			}catch (NoSuchElementException e) {
				System.out.println("썸네일 없음");
				movielist.setMovieImg("null");
			}
			
			// 예고편 저장
			//#contentData > div:nth-child(5) > div.tab-list.fixed > ul > li:nth-child(4) > a
			int vidcnt = Integer.parseInt(driver
					.findElement(By.xpath("/html/body/div[2]/div[4]/div[2]/div[2]/div/div[2]/div[1]/div/span[1]")).getText().substring(4, 5));
			System.out.println("예고편 개수"+vidcnt);
			if (vidcnt<=0) {
				System.out.println("예고편없음");
				movielist.setMovieVideo("null");
				System.out.println(movielist.getMovieVideo());
			} else {
				List<WebElement> video = driver.findElements(By.cssSelector("#videoTag>source"));
				System.out.println(movielist.getMovieVideo());
				System.out.println("예고편있음");
				String vidURL = video.get(0).getAttribute("src");
				URL vidurl = new URL(vidURL);
				BufferedInputStream bufferedInputStream = new BufferedInputStream(vidurl.openStream());
				FileOutputStream fileOutputStream = new FileOutputStream(path + "/video" +  movielist.getMovieRank() + ".mp4");
				int count = 0;
				byte[] b = new byte[1000];
//영상 저장 주석처리 
				while ((count = bufferedInputStream.read(b)) != -1) {
					fileOutputStream.write(b, 0, count);
				}
				String moviePath = realpath + "/video" +  movielist.getMovieRank() + ".mp4";
				movielist.setMovieVideo(moviePath);// 예고편 경로 저장
			}

			// DB저장
			Connection conn = null;
			PreparedStatement pstmt = null;
			int rows = 0;

			try {
				String url="jdbc:mariadb://127.0.0.1:3306/project";
				String user = "root";
				String pw="1234";
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection(url, user, pw);
				String sql = "insert into mega_movie(movie_title,movie_release,movie_summary,\n"
						+ "movie_age,movie_num,movie_type,movie_genre,movie_director,movie_actors,movie_img,movie_video,movie_rank) "
						+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, movielist.getMovieTitle());
				pstmt.setString(2, movielist.getMovieRelease());
				pstmt.setString(3, movielist.getMovieSummary());
				pstmt.setString(4, movielist.getMovieAge());
				pstmt.setString(5, movielist.getMovieNum());
				pstmt.setString(6, movielist.getMovieType());
				pstmt.setString(7, movielist.getMovieGenre());
				pstmt.setString(8, movielist.getMovieDirector());
				pstmt.setString(9, movielist.getMovieActors());
				pstmt.setString(10, movielist.getMovieImg());
				pstmt.setString(11, movielist.getMovieVideo());
				pstmt.setString(12, movielist.getMovieRank());
				rows = pstmt.executeUpdate();
				if (rows != 0)
					System.out.println(movielist.getMovieTitle()+"디비에 저장됐음");
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				//DBconn.close(conn, pstmt);
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			driver.close();
		}
	}
}
