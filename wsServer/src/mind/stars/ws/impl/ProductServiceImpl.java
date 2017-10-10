package mind.stars.ws.impl;

import java.util.ArrayList;
import java.util.List;

public class ProductServiceImpl {

	List<String> bookList = new ArrayList<String>();
	List<String> movieList = new ArrayList<String>();
	List<String> musicList = new ArrayList<String>();
	
	public ProductServiceImpl() {
		bookList.add("Inferno");
		bookList.add("JoyLand");
		bookList.add("The Game Of Thrones");
		
		movieList.add("Star Trek");
		movieList.add("Star Wars");
		movieList.add("Despicable Me");
		
		musicList.add("Arijit Singh");
		musicList.add("John Mayer");
		musicList.add("Charlie Puth");
	}
	
	public List<String> getProductCategories(){
		List<String>  categories = new ArrayList<String>();
		categories.add("Books");
		categories.add("Movies");
		categories.add("Music");
		return categories;
	}
	
	public List<String> getProducts(char category){
		switch (category) {
			case 'b':
				return bookList;
			case 'm':
				return movieList;
			case 'c':
				return musicList;
		}
		return null;
	}
}
