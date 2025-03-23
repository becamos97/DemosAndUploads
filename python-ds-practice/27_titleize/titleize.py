def titleize(phrase):
    """Return phrase in title case (each word capitalized).

        >>> titleize('this is awesome')
        'This Is Awesome'

        >>> titleize('oNLy cAPITALIZe fIRSt')
        'Only Capitalize First'
    """

    return ' '.join([s.capitalize() for s in phrase.split(' ')])
    
    #also a built in method

    #return phrase.title()
