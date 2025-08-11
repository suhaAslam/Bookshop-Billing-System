package com.pahanaedu.dao;
import com.pahanaedu.model.Bill;
import java.util.List;

public interface BillDAO {
    void addBill(Bill bill);
    Bill getBillById(int billId);
    List<Bill> getAllBills();
    void deleteBill(int billId);
}
