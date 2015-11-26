
def check_section(config, sec):
    """ Check if INI section exists, if not create it """
    try:
        config[sec]
        return True
    except:
        config[sec] = {}
        return False

def check_setting_int(config, cfg_name, item_name, def_val):
    try:
        my_val = int(config[cfg_name][item_name])
    except:
        my_val = def_val
        try:
            config[cfg_name][item_name] = my_val
        except:
            config[cfg_name] = {}
            config[cfg_name][item_name] = my_val
##    logger.debug(item_name + " -> " + str(my_val))
    return my_val

def check_setting_str(config, cfg_name, item_name, def_val, log=True):
    try:
        my_val = config[cfg_name][item_name]
    except:
        my_val = def_val
        try:
            config[cfg_name][item_name] = my_val
        except:
            config[cfg_name] = {}
            config[cfg_name][item_name] = my_val

##    if log:
##        logger.debug(item_name + " -> " + my_val)
##    else:
##        logger.debug(item_name + " -> ******")
    return my_val