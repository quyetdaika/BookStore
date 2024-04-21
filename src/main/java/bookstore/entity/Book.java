package bookstore.entity;

public class Book {
    private int id;
    private String name;
    private String author;
    private double price;
    private String category;
    private int page;
    private String fileName;
    private double deepth;
    private double height;
    private double width;

    public Book() {
    }

    public Book(String name, String author, double price, String category, int page, String fileName, double deepth, double height, double width) {
        this.name = name;
        this.author = author;
        this.price = price;
        this.category = category;
        this.page = page;
        this.fileName = fileName;
        this.deepth = deepth;
        this.height = height;
        this.width = width;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public double getDeepth() {
        return deepth;
    }

    public void setDeepth(double deepth) {
        this.deepth = deepth;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public double getWidth() {
        return width;
    }

    public void setWidth(double width) {
        this.width = width;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", author='" + author + '\'' +
                ", price=" + price +
                ", category='" + category + '\'' +
                ", page=" + page +
                ", fileName='" + fileName + '\'' +
                ", deepth=" + deepth +
                ", height=" + height +
                ", width=" + width +
                '}';
    }
}
