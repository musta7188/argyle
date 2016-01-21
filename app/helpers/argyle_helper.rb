module ArgyleHelper
  def plaid_link(options)
    raise Argyle::Error, "Public key must be set in Argyle configuration" unless Argyle.configuration.key
    raise Argyle::Error, "options[:name] is required for Plaid Link" unless options[:name]
    raise Argyle::Error, "options[:action] is required for Plaid Link" unless options[:action]

    id = options[:form_id] || 'plaidForm'
    product = options[:product] || Argyle.configuration.product
    env = options[:env] || Argyle.configuration.env

    plaid_link_form(id, options[:action]) + plaid_link_script(id, options[:name], product, env, options)
  end

  def plaid_link_form(id, action)
    form_tag action, method: 'POST', id: id
  end

  def plaid_link_script(id, name, product, env, options)
    javascript_tag '', src: Argyle.configuration.plaid_src, data: {'client-name' => name, 'form-id' => id, 'key' => Argyle.configuration.key, 'product' => product, 'env' => env, 'webhook' => options[:webhook], 'token' => options[:token] }
  end
end
