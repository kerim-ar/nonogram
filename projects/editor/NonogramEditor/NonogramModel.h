#ifndef NONOGRAMMODEL_H
#define NONOGRAMMODEL_H

#include <QString>

class NonogramModel
{
public:
    NonogramModel(QString const & title, QString const & comment);
    QString Title() const;
    QString Comment() const;
private:
    QString m_title;
    QString m_comment;
};

#endif // NONOGRAMMODEL_H
