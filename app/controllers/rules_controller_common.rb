module RulesControllerCommon
  
  def get_rules(param_key)
    def safe_values(hash, key)
      h = hash[key]
      h.nil? ? [] : h.values
    end
      
    rules_hash = params[param_key] || {}
    res = rules_hash.values.map do |v| 
      { 'matchings' => safe_values(v,'matchings'), 'actions' => safe_values(v,'actions') } 
    end
    
    res
  end
  
end