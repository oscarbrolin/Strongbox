//
//  DatabaseCellSubtitleField.h
//  Strongbox
//
//  Created by Mark on 30/07/2019.
//  Copyright © 2019 Mark McGuill. All rights reserved.
//

#ifndef DatabaseCellSubtitleField_h
#define DatabaseCellSubtitleField_h

typedef NS_ENUM (NSInteger, DatabaseCellSubtitleField) {
    kDatabaseCellSubtitleFieldNone,
    kDatabaseCellSubtitleFieldFileName,
    kDatabaseCellSubtitleFieldStorage,
    kDatabaseCellSubtitleFieldLastModifiedDate,
    kDatabaseCellSubtitleFieldLastModifiedDatePrecise,
    kDatabaseCellSubtitleFieldFileSize,
};

#endif /* DatabaseCellSubtitleField_h */
