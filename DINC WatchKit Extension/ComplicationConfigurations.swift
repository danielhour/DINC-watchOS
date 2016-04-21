//
//  ComplicationConfigurations.swift
//  DINC
//
//  Created by dhour on 4/15/16.
//  Copyright © 2016 DHour. All rights reserved.
//


import ClockKit


/**
 * Helper class to setup custom complications
 */
class ComplicationConfigurations {
    
    
    //---------------------------------------------------------------------------------------------------------
    
    // MARK: - Modular Small Family
    
    
    /**
    Complication template for Modular Small Simple Text
    
    - parameter text: String
    - parameter textShort: String
    
    - returns: CLKComplicationTemplateModularSmallSimpleText
    */
    class func modularSmallSimpleText(text: String, textShort: String?, textColor: UIColor) -> CLKComplicationTemplateModularSmallSimpleText {
        
        let template = CLKComplicationTemplateModularSmallSimpleText()
        template.textProvider = CLKSimpleTextProvider(text: text, shortText: textShort)
        template.textProvider.tintColor = Theme.Colors.green
        return template
    }
    
    
    /**
     Complication template for Modular Small Stack Text
     
     - parameter line1: String
     - parameter line2: String
     
     - returns: CLKComplicationTemplateModularSmallStackText
     */
    class func modularSmallStackText(line1: String, line2: String, line2Short: String?) -> CLKComplicationTemplateModularSmallStackText {
        
        let template = CLKComplicationTemplateModularSmallStackText()
        template.line1TextProvider = CLKSimpleTextProvider(text: line1)
        template.line2TextProvider = CLKSimpleTextProvider(text: line2, shortText: line2Short)
        template.highlightLine2 = true
        return template
    }
    
    
    /**
     Complication template for Modular Small Stack Image (one piece image)
     
     - parameter image: UIImage
     - parameter line2: String
     - parameter line2Short: String?
     
     - returns: CLKComplicationTemplateModularSmallStackImage
     */
    class func modularSmallStackImage(image: UIImage, line2: String, line2Short: String?) -> CLKComplicationTemplateModularSmallStackImage {
        
        let template = CLKComplicationTemplateModularSmallStackImage()
        template.line1ImageProvider = CLKImageProvider(onePieceImage: image)
        template.line2TextProvider = CLKSimpleTextProvider(text: line2, shortText: line2Short)
        
        return template
    }
    
    
    //-- smallsimpleimage
    //-- smallringtext
    //-- smallringimage
    //-- smallcolumnstext
    
    
    //---------------------------------------------------------------------------------------------------------
    
    // MARK: - Modular Large Family
    
    /**
    Complication template for Modular Large Tall Body
    
    - parameter header: String
    - parameter body: String
    
    - returns: CLKComplicationTemplateModularLargeTallBody
    */
    class func modularLargeTallBody(header: String, body: String, bodyShort: String?) -> CLKComplicationTemplateModularLargeTallBody {
        
        let template = CLKComplicationTemplateModularLargeTallBody()
        template.headerTextProvider = CLKSimpleTextProvider(text: header)
        template.bodyTextProvider = CLKSimpleTextProvider(text: body, shortText: bodyShort)
        return template
    }
    
    //-- largestandardbody (no image)
    //-- largestandardbody (w/image)
    //-- largecolumns
    //-- largetable
    
    
    //---------------------------------------------------------------------------------------------------------
    
    // MARK: - Utilitarian Small Family
    
    /**
    Complication template for Utilitarian Small Flat (no image)
    
    - parameter imageName: String
    - parameter text: String
    
    - returns: CLKComplicationTemplateUtilitarianSmallFlat
    */
    class func utilitarianSmallFlat(imageName: String, text: String, textShort: String?) -> CLKComplicationTemplateUtilitarianSmallFlat {
        
        let template = CLKComplicationTemplateUtilitarianSmallFlat()
        template.imageProvider = nil
        template.textProvider = CLKSimpleTextProvider(text: text, shortText: textShort)
        return template
    }
    
    //-- smallflat (w/image)
    //-- smallsquare
    //-- smallringtext
    //-- smallringimage
    
    
    //---------------------------------------------------------------------------------------------------------
    
    // MARK: - Utilitarian Large Family
    
    /**
    Complication template for Utilitarian Large Flat (no image)
    
    - parameter imageName: String
    - parameter text: String
    
    - returns: CLKComplicationTemplateUtilitarianLargeFlat
    */
    class func utilitarianLargeFlat(imageName: String, text: String, textShort: String?) -> CLKComplicationTemplateUtilitarianLargeFlat {
        
        let template = CLKComplicationTemplateUtilitarianLargeFlat()
        template.imageProvider = nil
        template.textProvider = CLKSimpleTextProvider(text: text, shortText: textShort)
        return template
    }
    
    
    //---------------------------------------------------------------------------------------------------------
    
    // MARK: - Circular Small Family
    
    /**
    Complication template for Circular Small Simple Text
    
    - parameter text: String
    
    - returns: CLKComplicationTemplateCircularSmallSimpleText
    */
    class func circularSmallSimpleText(text: String, textShort: String?) -> CLKComplicationTemplateCircularSmallSimpleText {
        
        let template = CLKComplicationTemplateCircularSmallSimpleText()
        template.textProvider = CLKSimpleTextProvider(text: text, shortText: textShort)
        return template
    }
    
    
    /**
     Complication template for Circular Small Stack Text (no short text)
     
     - parameter line1: String
     - parameter line2: String
     
     - returns: CLKComplicationTemplateCircularSmallStackText
     */
    class func circularSmallStackText(line1: String, line2: String, line2Short: String?) -> CLKComplicationTemplateCircularSmallStackText {
        
        let template = CLKComplicationTemplateCircularSmallStackText()
        template.line1TextProvider = CLKSimpleTextProvider(text: line1)
        template.line2TextProvider = CLKSimpleTextProvider(text: line2, shortText: line2Short)
        return template
    }
    
    //-- small stack image
    //-- small simple image
    //-- small ring text
    //-- small ring image

    
}