# TASK

1. Create `seed.rb` to import data from the `db/goods.xlsx` file.

2. The query `GET/sales` should return JSON containing the goods revenue for the period given.

`revenue` is the total income by a given product for the period given.

`total_revenue` is the total of all the revenues for the period given.

EXAMPLE:

**GET /sales?from=2017-03-01&to=2017-03-01**

```
{
  "from": "2017-03-01",
  "to": "2017-03-01",
  "goods": [
    {
      "title": "Artificial Flowers",
      "revenue": 72540.04
    },
    {
      "title": "Baked Goods",
      "revenue": 34032.77
    },
    {
      "title": "Bamboo",
      "revenue": 69361.16
    },
    {
      "title": "Bananas",
      "revenue": 181035.55
    },
    {
      "title": "Beans (green beans)",
      "revenue": 183969.57
    }
  ],
  "total_revenue": 540939.09
}
```

In case if dates do not conform to the format prescribed or `from` > `to` the 422 error with JSON description should be returned.

3. Make a page looking like that:

![Table](https://github.com/programrails/motorsport/blob/master/app/assets/images/table.png)

4. The data has to be renewed by the 'Refresh' button without the page reload.

5. Make a standard CRUD for goods (without AJAX).

6. Make an API - for the CRUD mentioned and for showing one/all revenues for one product.

7. Make an authorisation - for that API only.

8. Cover the code with RSpec and shoulda-matchers tests.

9. Install and use Rubocop and also fine tune its settings for this project.

10. Install and use SimpleCov.
