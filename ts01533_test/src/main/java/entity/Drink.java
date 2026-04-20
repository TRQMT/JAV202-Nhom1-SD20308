package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Drink {
    Integer id;
    Integer categoryId;
    String name;
    String categoryName;  // tên loại: "Cà phê", "Trà sữa"...
    int price;
    boolean active;
}