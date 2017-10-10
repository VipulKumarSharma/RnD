package Cloning;

class Rectangle implements Cloneable{
    private int width;
    private int height;
  
    public Rectangle(int w, int h){
        width = w;
        height = h;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public void setWidth(int width) {
        this.width = width;
    }
  
    public int area(){
        return width * height;
    }
  
    @Override
    public String toString(){
        return String.format("Rectangle [width: %d, height: %d, area: %d]", width, height, area());
    }

    @Override
    protected Rectangle clone() throws CloneNotSupportedException {
        return (Rectangle) super.clone();
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Rectangle other = (Rectangle) obj;
        if (this.width != other.width) {
            return false;
        }
        if (this.height != other.height) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 47 * hash + this.width;
        hash = 47 * hash + this.height;
        return hash;
    }
}

public class ObjectCloning {
    
	public static void main(String args[]) {

        Rectangle rec = new Rectangle(30, 60);
        System.err.println(rec);
      
        Rectangle copy = null;
        try {
            System.err.println("Creating Copy of this object using Clone method");
            copy = rec.clone();
            System.err.println("Copy " + copy);
          
        } catch (CloneNotSupportedException ex) {
            System.out.println("Cloning is not supported for this object");
        }
      
        //testing properties of object returned by clone method in Java
        System.err.println("copy != rec : " + (copy != rec));
        System.err.println("copy.getClass() == rec.getClass() : " + (copy.getClass() == rec.getClass()));
        System.err.println("copy.equals(rec) : " + copy.equals(rec));
      
        //Updating fields in original object
        rec.setHeight(100);
        rec.setWidth(45);
      
        System.err.println("Original object :" + rec);
        System.err.println("Clonned object  :" + copy);
    }
 
}