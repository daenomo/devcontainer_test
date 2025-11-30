-- 2つの独立した文脈を組み合わせる
import Control.Applicative
import Control.Monad ( (>=>) )

exampleApplicative :: Maybe Int
--exampleApplicative = pure (+1) <*> Just 3
exampleApplicative = (+1) <$> Just 3

-- 前の結果に依存して次の処理を決める
exampleMonad :: Maybe Int
exampleMonad = Just 3 >>= \x -> Just (x + 1)
-- 結果: Just 4
-- main 関数で結果を表示
main :: IO ()
main = do
  putStrLn $ "Applicative result: " ++ show exampleApplicative
  putStrLn $ "Monad result: " ++ show exampleMonad  
  putStrLn $ show (Just <$> Just 5)
  putStrLn $ show (pipeline 0)

a = pure 1 :: Maybe Int


-- 失敗する可能性のある関数
safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

-- 2つの関数をKleisli合成
step1 :: Int -> Maybe Int
step1 = \x -> Just (x + 10)

step2 :: Int -> Maybe Int
step2 = \x -> safeDiv x 2

pipeline :: Int -> Maybe Int
pipeline = step1 >=> step2

-- 実行例
-- pipeline 10 = Just 10 -> Just 20 -> Just 10
-- pipeline 0  = Just 0 -> Just 10 -> Just 5
