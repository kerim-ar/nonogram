#ifndef NONOGRAMMODEL_H
#define NONOGRAMMODEL_H

#include <QString>
#include <QVector>
#include <QAbstractListModel>

class NonogramModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString comment READ comment WRITE setComment NOTIFY commentChanged)

public:
    explicit NonogramModel(QObject *parent = 0);
    ~NonogramModel();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;

    QString title() const;
    void setTitle(const QString &title);

    QString comment() const;
    void setComment(const QString &comment);

signals:
    void titleChanged();
    void commentChanged();

private:
    QString m_title;
    QString m_comment;
    QVector<int> m_cells;
};

#endif // NONOGRAMMODEL_H
