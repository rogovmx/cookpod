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


Cookpod.Repo.insert!(%Cookpod.User{email: "a1@a.a", password: "pass", password_confirmation: "pass"})
Cookpod.Repo.insert!(%Cookpod.User{email: "z@x.c", password: "pass", password_confirmation: "pass"})