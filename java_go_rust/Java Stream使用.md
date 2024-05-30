# Java Stream使用

## 根据id分组统计

```
class Item {
    int id;
    String name;
 
    public Item(int id, String name) {
        this.id = id;
        this.name = name;
    }
 
    public int getId() {
        return id;
    }
}
 
public class GroupByIdCountExample {
    public static void main(String[] args) {
        List<Item> items = Arrays.asList(
            new Item(1, "Item1"),
            new Item(2, "Item2"),
            new Item(1, "Item1"),
            new Item(3, "Item3")
        );
 
        Map<Integer, Long> countByGroupId = items.stream()
            .collect(Collectors.groupingBy(Item::getId, Collectors.counting()));
 
        System.out.println(countByGroupId);
    }
}
```
