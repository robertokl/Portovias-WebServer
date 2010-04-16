require 'mechanize'

class Portovias
  CREDENTIALS = {"robertokl@gmail.com" => "300688", "vinicius@sordido.com.br" => "achador"}
  INVALID_CHARACTERES = ["\240","\r","\n", " "]
  SPECIAL_CHARACTER = "\273"
  
  def self.find_best_way(login = "robertokl@gmail.com")
    agent = Mechanize.new
    agent.get("https://wwws.portovias.com.br/PortalPortoVias/aspx/welcome.aspx")
    agent.page.forms.first.send("ctl00$ContentGeral$txtUsuario", login)
    agent.page.forms.first.send("ctl00$ContentGeral$txtSenha", Portovias::CREDENTIALS[login])
    agent.page.forms.first.click_button
    agent.get("https://wwws.portovias.com.br/portalportovias/aspx/meusTrajetos.aspx")
    faster = {}
    (1..50).each do |i|
      th = agent.page.search("//*[@id='%d' and @class='trajeto']//th" % i).first
      if th
        f = {}
        c = agent.page.search("//table[@id='#{i}' and @class='trajeto']//tr[@class='caminhos']//div[@class='showName']")#//*[@id='%d' and @class='trajeto']//th[@class='']" % i)#"//*[@id='ctl00_ctl00_ContentGeral_ContentPrincipal_rptTrajetos_ctl%.2d_rptCaminhos_ctl%.2d_nomeCaminho']" % [i, j])
        t = agent.page.search("//table[@id='#{i}' and @class='trajeto']//tr[@class='caminhos']//td[3]")#("//table[@id=1 and @class='trajeto']//tr[@class='caminhos']//div[@class='showName']")#"//*[@id='ctl00_ctl00_ContentGeral_ContentPrincipal_rptTrajetos_ctl%.2d_rptCaminhos_ctl%.2d_tempoEstimado']" % [i, j])
        (0..(c.size - 1)).each do |j|
          f.merge!({format_trim(t[j].text) => format_trim(c[j].text)})
        end
        faster.merge!({format_trim(th.text) => [f.keys.sort.first, f[f.keys.sort.first]]})
      end
    end
    return faster
  end  

  def self.format_trim(text)
    INVALID_CHARACTERES.each { |ic| text = text.gsub(ic, "") }
    text = text.gsub(SPECIAL_CHARACTER, " > ")
    text = text[0..(text =~ /\(partin/) - 1] if text =~ /partindo/
    text = text[1..text.length] if text =~ /\302/m
    text = text[0..(text =~ /\302/) - 1] + text[(text =~ /\302/) + 1..text.length] if text =~ /\302/m
    return text
  end
end
