class Object
  def cdebug(tag=nil)
    RAILS_DEFAULT_LOGGER.info "\n\033[1;33;44m#{tag}\033[1;32;40m#{self.class} \033[0;30;47m#{self.inspect}\033[0m"
  end
  def cdump(tag=nil)
    RAILS_DEFAULT_LOGGER.info "\n\033[1;33;44m#{tag}\033[1;32;44m #{self.class}\033[0m\n"
    if self.class == Class
      RAILS_DEFAULT_LOGGER.info "\033[1;34;47mMethods\033[0m\n"
      self.methods.sort.each{|m|RAILS_DEFAULT_LOGGER.info "\t\033[1;36;40m#{m}\033[0m\n"}
    end
    if self.methods.include?('each_key')
      RAILS_DEFAULT_LOGGER.info "\033[1;34;47mPairs\033[0m\n"
      self.each_key{|k|RAILS_DEFAULT_LOGGER.info "\t\033[0;32;40m#{k} => \t\t\033[0;37;40m#{self[k]}\033[0m\n"}
    end
    if self.methods.include?('each_index')
      RAILS_DEFAULT_LOGGER.info "\033[1;34;47mValues\033[0m\n"
      self.each_index{|k|RAILS_DEFAULT_LOGGER.info "\t\033[0;32;40m#{k}:\t\t\033[0;37;40m#{self[k]}\033[0m\n"}
    end
    if self.methods.include?('attributes')
      RAILS_DEFAULT_LOGGER.info "\033[1;34;47mAttributes\033[0m\n"
      self.attribute_names.sort.each{|a|RAILS_DEFAULT_LOGGER.info "\t\033[0;35;40m#{a}:\t\t\033[0;37;40m#{self.send(a)}\033[0m\n"}
    end
  end
end