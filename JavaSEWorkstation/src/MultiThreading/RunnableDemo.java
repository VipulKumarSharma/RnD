package MultiThreading;

class MyRunnable implements Runnable {
	
	MyRunnable() {
		Thread t = new Thread(this);
		t.start();
	}
	
	public void run() {
		System.out.println("MyRunnable run()");
	}
}

public class RunnableDemo {
	public static void main(String[] args) {
		MyRunnable mr = new MyRunnable();
		/*Thread t = new Thread(mr);
		t.start();*/
	}
}

