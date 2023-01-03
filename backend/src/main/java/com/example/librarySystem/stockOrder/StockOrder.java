package com.example.librarySystem.stockOrder;

import lombok.*;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true,fluent = true)
@Builder
public class StockOrder {
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private final int id;
    @NonNull
    private int isbn;
    @NonNull
    private int quantity;
}
