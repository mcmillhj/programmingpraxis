datatype Expr =
         | Var of string
         | Const of int
         | Add of Expr * Expr
         | Mul of Expr * Expr;
