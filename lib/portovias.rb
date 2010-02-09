require 'mechanize'
def find_best_way
	agent = Mechanize.new
	agent.get("https://wwws.portovias.com.br/PortalPortoVias/aspx/welcome.aspx")
	agent.page.forms.first.send("ctl00$ctl00$ContentGeral$ContentPrincipal$txtUsuario", "robertokl@gmail.com")
	agent.page.forms.first.send("ctl00$ctl00$ContentGeral$ContentPrincipal$txtSenha", "300688")
	agent.page.forms.first.click_button
	agent.get("https://wwws.portovias.com.br/portalportovias/aspx/meusTrajetos.aspx")
	faster = {}
	(1..50).each do |i|
		th = agent.page.search("//*[@id='ctl00_ctl00_ContentGeral_ContentPrincipal_rptTrajetos_ctl%.2d_nomeTrajeto']" % i)
		unless th.empty?
			f = {}
			(0..49).each do |j|
				c = agent.page.search("//*[@id='ctl00_ctl00_ContentGeral_ContentPrincipal_rptTrajetos_ctl%.2d_rptCaminhos_ctl%.2d_nomeCaminho']" % [i, j])
				t = agent.page.search("//*[@id='ctl00_ctl00_ContentGeral_ContentPrincipal_rptTrajetos_ctl%.2d_rptCaminhos_ctl%.2d_tempoEstimado']" % [i, j])
				f.merge!({t.text => c.text}) unless c.empty?
			end
			faster.merge!({th.text => [f.keys.sort.first, f[f.keys.sort.first]]})
		end
	end
	return faster
end
