class Proc
  def not
    -> (*args, &blk){
      !self.(*args,&blk)
    }
  end
end
