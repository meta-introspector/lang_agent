module Test2 where

import qualified Prelude

__ :: any
__ = Prelude.error "Logical or arity value used"

data Total2 t p =
   Tpair t p

type Dirprod x y = Total2 x y

make_dirprod :: a1 -> a2 -> Dirprod
                a1 a2
make_dirprod x y =
  Tpair x y

t_archtype_athena2 :: Dirprod () ()
t_archtype_athena2 =
  make_dirprod __ __

