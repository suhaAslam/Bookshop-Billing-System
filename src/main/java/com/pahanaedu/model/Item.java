package com.pahanaedu.model;

public class Item {
    private int itemId;
    private String name;
    private String description;
    private double price;
    private int quantityInStock;

    public static class Builder {
        private int itemId;
        private String name;
        private String description;
        private double price;
        private int quantityInStock;

        public Builder setItemId(int itemId) {
            this.itemId = itemId;
            return this;
        }
        public Builder setName(String name) {
            this.name = name;
            return this;
        }
        public Builder setDescription(String description) {
            this.description = description;
            return this;
        }
        public Builder setPrice(double price) {
            this.price = price;
            return this;
        }
        public Builder setQuantityInStock(int quantity) {
            this.quantityInStock = quantity;
            return this;
        }
        public Item build() {
            return new Item(this);
        }
    }

    private Item(Builder builder) {
        this.itemId = builder.itemId;
        this.name = builder.name;
        this.description = builder.description;
        this.price = builder.price;
        this.quantityInStock = builder.quantityInStock;
    }

    public int getItemId() { return itemId; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
    public int getQuantityInStock() { return quantityInStock; }


}
