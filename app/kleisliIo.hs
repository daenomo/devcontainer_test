import Control.Monad ( (>=>) )

-- ユーザーに入力を求める関数
askName :: () -> IO String
askName _ = do
  putStrLn "名前を入力してください:"
  getLine

-- 入力を加工して表示する関数
greet :: String -> IO ()
greet name  = putStrLn ("こんにちは, " ++ name ++ "!")

-- Kleisli合成
pipelineIO :: () -> IO ()
pipelineIO = askName >=> greet

-- 実行例
-- pipelineIO ()
-- ユーザーが "ロウ" と入力すると
-- 出力: "こんにちは, ロウ!"
main :: IO ()
main = do
  pipelineIO ()

-- 左単位律の例
exampleLeftUnit :: Maybe Int
exampleLeftUnit = return 3 >>= (\x -> Just (x+1))
-- = Just 3 >>= (\x -> Just (x+1))
-- = Just 4
-- 同じく (\x -> Just (x+1)) 3 = Just 4

-- 右単位律の例
exampleRightUnit :: Maybe Int
exampleRightUnit = Just 3 >>= return
-- = Just 3

