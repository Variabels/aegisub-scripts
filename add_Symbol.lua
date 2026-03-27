local tr = aegisub.gettext

script_name = tr"Add Symbol"
script_description = tr"Add a styled symbol to the front of selected lines"
script_author = "Variabels"
script_version = "1.0"


function get_config_dialog(subs)

    local dropd = {}
    local symbs = {"♦","♥","♠","♣","●","♪","♫","▲","▼","■"}

	local config_dialog = {
        {class = "label", label = "Choose Symbol", x = 0, y = 1, width = 1, height = 1},
        {x=3,y=1,width=1,height=1,class="dropdown",name="symbols", items = symbs},
		{class = "label", label = "Choose symbol Style",x = 0, y = 0, width = 1, height = 1}
	}
	
	for i = 1, #subs do
		local l = subs[i]
		if l.class == "style" then
            dropd[i] = l.name
		end
	end
    table.insert(config_dialog, {x=3,y=0,width=1,height=1,class="dropdown",name="styles", items = dropd})
    
	return config_dialog 
end

function add_Symbol(subs, sel)

    button, results = aegisub.dialog.display(get_config_dialog(subs), {"OK","Cancel"})
	if button == "OK" then
        
        insertions = 0
        for _, i in ipairs(sel) do
            i = i + insertions
            line = subs[i]
            line.text = "{\\k0\\r" .. results.styles .. "}" .. results.symbols .. "{\\r} " .. line.text
            subs[i] = line
        end
    else
        aegisub.cancel()
    end
end

aegisub.register_macro(script_name, script_description, add_Symbol)