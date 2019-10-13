"""
Openwhisk helper action that get called whenever recording file is ready to be consumed
"""

def main(args):
    ipaddress = args.get('ipaddress')
    if not ipaddress:
        return {'error': 'Missing ipaddress'}
    filename = args.get('filename')
    if not filename:
        return {'error': 'Missing filename'}

    return {'filename' : str(filename), 'ipaddress': str(ipaddress)}
