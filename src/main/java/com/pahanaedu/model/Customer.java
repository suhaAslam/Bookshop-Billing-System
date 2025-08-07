package com.pahanaedu.model;

public class Customer {
    private int accountNumber;
    private String name;
    private String address;
    private String phoneNumber;
    private int unitsConsumed;

    private Customer(CustomerBuilder builder) {
        this.accountNumber = builder.accountNumber;
        this.name = builder.name;
        this.address = builder.address;
        this.phoneNumber = builder.phoneNumber;
        this.unitsConsumed = builder.unitsConsumed;
    }

    public int getAccountNumber() { return accountNumber; }
    public String getName() { return name; }
    public String getAddress() { return address; }
    public String getPhoneNumber() { return phoneNumber; }
    public int getUnitsConsumed() { return unitsConsumed; }

    public static class CustomerBuilder {
        private int accountNumber;
        private String name;
        private String address;
        private String phoneNumber;
        private int unitsConsumed;

        public CustomerBuilder setAccountNumber(int accountNumber) {
            this.accountNumber = accountNumber;
            return this;
        }

        public CustomerBuilder setName(String name) {
            this.name = name;
            return this;
        }

        public CustomerBuilder setAddress(String address) {
            this.address = address;
            return this;
        }

        public CustomerBuilder setPhoneNumber(String phoneNumber) {
            this.phoneNumber = phoneNumber;
            return this;
        }

        public CustomerBuilder setUnitsConsumed(int unitsConsumed) {
            this.unitsConsumed = unitsConsumed;
            return this;
        }

        public Customer build() {
            return new Customer(this);
        }
    }
}