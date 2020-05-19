# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cookpod.Repo.insert!(%Cookpod.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Cookpod.Recipes.Recipe
alias Cookpod.Recipes.Ingredient
alias Cookpod.Recipes.Product
alias Cookpod.Repo

# Cookpod.Repo.insert!(%Cookpod.User{
#   email: "a1@a.a",
#   password: "pass",
#   password_confirmation: "pass"
# })

# Cookpod.Repo.insert!(%Cookpod.User{
#   email: "z@x.c",
#   password: "pass",
#   password_confirmation: "pass"
# })

leek = Repo.insert!(%Product{name: "leek", carbs: 14, fats: 5, proteins: 5})
garlic = Repo.insert!(%Product{name: "garlic", carbs: 70, fats: 6, proteins: 5})
broccoli = Repo.insert!(%Product{name: "broccoli", carbs: 75, fats: 1, proteins: 3})
butter = Repo.insert!(%Product{name: "butter", carbs: 1, fats: 80, proteins: 1})
thyme = Repo.insert!(%Product{name: "thyme", carbs: 0, fats: 0, proteins: 0})
flour = Repo.insert!(%Product{name: "flour", carbs: 700, fats: 1, proteins: 10})
milk = Repo.insert!(%Product{name: "milk", carbs: 4, fats: 3, proteins: 3})
macaroni = Repo.insert!(%Product{name: "dried macaroni", carbs: 75, fats: 1, proteins: 14})
parmesan =
  Repo.insert!(%Product{name: "Parmesan cheese", carbs: 3, fats: 25, proteins: 35})
cheddar = Repo.insert!(%Product{name: "Cheddar cheese", carbs: 1, fats: 33, proteins: 24})
spinach = Repo.insert!(%Product{name: "spinach", carbs: 4, fats: 0, proteins: 2})
almonds = Repo.insert!(%Product{name: "almonds", carbs: 16, fats: 57, proteins: 18})

recipe =
  Repo.insert!(%Recipe{
    name: "Greens mac 'n' cheese 4",
    state: "published",
    description: """
    A Friday-night favourite, this is a twist on a comfort classic that uses
    broccoli in two ways – the blitzed-up stalks add colour and punch to the
    sauce, while you enjoy the delicate florets with your pasta. Join the green team!
    """
  })

Repo.insert!(%Ingredient{recipe: recipe, amount: 10, product: leek})
Repo.insert!(%Ingredient{recipe: recipe, amount: 30, product: garlic})
Repo.insert!(%Ingredient{recipe: recipe, amount: 400, product: broccoli})
Repo.insert!(%Ingredient{recipe: recipe, amount: 40, product: butter})
Repo.insert!(%Ingredient{recipe: recipe, amount: 15, product: thyme})
Repo.insert!(%Ingredient{recipe: recipe, amount: 20, product: flour})
Repo.insert!(%Ingredient{recipe: recipe, amount: 90, product: milk})
Repo.insert!(%Ingredient{recipe: recipe, amount: 450, product: macaroni})
Repo.insert!(%Ingredient{recipe: recipe, amount: 30, product: parmesan})
Repo.insert!(%Ingredient{recipe: recipe, amount: 150, product: cheddar})
Repo.insert!(%Ingredient{recipe: recipe, amount: 100, product: spinach})
Repo.insert!(%Ingredient{recipe: recipe, amount: 50, product: almonds})