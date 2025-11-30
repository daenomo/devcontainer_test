import Data.List (sort)
-- 型宣言
data Shape = Circle Double | Rectangle Double Double
 deriving (Show, Eq)


-- 値を作るときはコンストラクタを使う
c1 :: Shape
c1 = Circle 10.0

r1 :: Shape
r1 = Rectangle 3.0 4.0

-- 小文字始まりは関数
area :: Shape -> Double
area (Circle r) = pi * r^2
area (Rectangle w h) = w * h

main :: IO ()
main = do
  putStrLn $ "Area of c1: " ++ show (area c1)
  putStrLn $ "Area of r1: " ++ show (area r1)
  eqTest
  ordTest

eqTest :: IO ()
eqTest = do
  let c1 = Circle 10.0
      c2 = Circle 10.0
      r1 = Rectangle 3.0 4.0
  putStrLn $ "c1 == c2 ? " ++ show (c1 == c2)   -- True
  putStrLn $ "c1 == r1 ? " ++ show (c1 == r1)   -- False

instance Ord Shape where
  compare s1 s2 = compare (area s1) (area s2)

ordTest :: IO ()
ordTest = do
  let shapes = [Circle 5.0, Rectangle 2.0 3.0, Circle 10.0, Rectangle 1.0 1.0]
  putStrLn "Sorted shapes:"
  print (sort shapes)
